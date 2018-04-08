import 'dart:web_gl';
import 'dart:typed_data';
import 'package:vector_math/vector_math.dart';
import 'package:zenith/zenith.dart';
import '../game.dart';

class WebGLPlane extends Plane2D {
  final HtmlGame _game;

  WebGLPlane(this._game, Vector3 position, Vector3 size, Vector4 color)
      : super(position, size, color);

  @override
  void draw(Game game, World world) {
    vertexArrays();
  }

  void vertexArrays() {
    var positions = <double>[];
    var world = _game.world;

    var colors = <double>[];

    for (int i = 0; i < 4; i++)
      colors.addAll([color.r, color.g, color.b, color.a]);

    // The coordinates..
    var topLeft = [
      world.normalizeX(position.x - (size.x / 2)),
      world.normalizeY(position.y - (size.y / 2)),
      world.normalizeZ(position.z),
    ];

    var topRight = [
      world.normalizeX(position.x + (size.x / 2)),
      world.normalizeY(position.y - (size.y / 2)),
      world.normalizeZ(position.z),
    ];

    var bottomLeft = [
      world.normalizeX(position.x - (size.x / 2)),
      world.normalizeY(position.y + (size.y / 2)),
      world.normalizeZ(position.z),
    ];

    var bottomRight = [
      world.normalizeX(position.x + (size.x / 2)),
      world.normalizeY(position.y + (size.y / 2)),
      world.normalizeZ(position.z),
    ];

    positions
      ..addAll(topLeft)
      ..addAll(topRight)
      ..addAll(bottomLeft)
      ..addAll(bottomRight);

    const numComponents = 3;

    var gl = _game.world.context;
    var program = _game.world.program;

    var vertexShader = gl.createShader(VERTEX_SHADER),
        fragmentShader = gl.createShader(FRAGMENT_SHADER);

    gl.shaderSource(vertexShader, '''
      attribute vec4 aVertexPosition;
      attribute vec4 aVertexColor;
      uniform mat4 uModelViewMatrix;
      uniform mat4 uProjectionMatrix;
      varying lowp vec4 vColor;
      
      void main(void) {
        gl_Position = uProjectionMatrix * uModelViewMatrix * aVertexPosition;
        vColor = aVertexColor;
      }
    ''');

    // Fragment shader
    gl.shaderSource(fragmentShader, '''
      varying lowp vec4 vColor;
      
      void main(void) {
        gl_FragColor = vColor;
      }
    ''');

    gl
      ..compileShader(vertexShader)
      ..compileShader(fragmentShader)
      ..attachShader(program, fragmentShader)
      ..attachShader(program, vertexShader)
      ..linkProgram(program);

    var vertexPosition = gl.getAttribLocation(program, 'aVertexPosition'),
        vertexColor = gl.getAttribLocation(program, 'aVertexColor'),
        projectionMatrix = gl.getUniformLocation(program, 'uProjectionMatrix'),
        modelViewMatrix = gl.getUniformLocation(program, 'uModelViewMatrix'),
        colorBuffer = gl.createBuffer(),
        positionBuffer = gl.createBuffer(),
        indexBuffer = gl.createBuffer();

    var indices = [0, 1, 2, 0, 2, 3];

    var mProjection = new Matrix4.identity(), mModelView = new Matrix4.identity();
    var projection = new Float32List(16), modelView = new Float32List(16);
    mProjection.copyIntoArray(projection);
    mModelView.copyIntoArray(modelView);

    gl
      ..vertexAttribPointer(vertexPosition, 3, FLOAT, false, 0, 0)
      ..enableVertexAttribArray(vertexPosition)
      ..vertexAttribPointer(vertexColor, 4, FLOAT, false, 0, 0)
      ..enableVertexAttribArray(vertexPosition)
      ..bindBuffer(ARRAY_BUFFER, positionBuffer)
      ..bufferData(
          ARRAY_BUFFER, new Float32List.fromList(positions), STATIC_DRAW)
      ..bindBuffer(ARRAY_BUFFER, colorBuffer)
      ..bufferData(ARRAY_BUFFER, new Float32List.fromList(colors), STATIC_DRAW)
      ..bindBuffer(ELEMENT_ARRAY_BUFFER, indexBuffer)
      ..bufferData(
          ELEMENT_ARRAY_BUFFER, new Uint16List.fromList(indices), STATIC_DRAW)
      ..bindBuffer(ELEMENT_ARRAY_BUFFER, indexBuffer)
      ..useProgram(program)
      ..uniformMatrix4fv(projectionMatrix, false, projection)
      ..uniformMatrix4fv(modelViewMatrix, false, modelView)
      ..drawElements(TRIANGLES, indices.length, UNSIGNED_SHORT, 0);

    program = gl.createProgram();
  }
}
