import 'dart:math';
import 'dart:web_gl';
import 'dart:typed_data';
import 'package:vector_math/vector_math.dart';
import 'package:zenith/zenith.dart';
import '../game.dart';
import 'plane.fragment.glsl.dart';
import 'plane.vertex.glsl.dart';
import 'webgl_draw.dart';

class WebGLPlane extends Plane2D {
  final HtmlGame _game;

  WebGLPlane(this._game, Vector3 position, Vector3 size, Vector4 color)
      : super(position, size, color);

  @override
  void draw(Game game, World world) {
    var positions = <double>[];
    var colors = new List<double>(4);
    color.copyIntoArray(colors);

    //for (int i = 0; i < 4; i++)
    //  colors.addAll([color.r, color.g, color.b, color.a]);

    /*
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
      ..addAll(bottomRight);*/

    positions.addAll([1.0, 1.0, -1.0, 1.0, 1.0, -1.0, -1.0, -1.0]);

    var gl = _game.world.context;
    var program = _game.world.program;

    /// Use handy pre-built shaders to save a major headache!!!
    planeVertexShader.compile(gl, program);
    planeFragmentShader.compile(gl, program);
    gl..linkProgram(program);

    var indices = [0, 1, 2, 0, 2, 3];

    var projection = new Matrix4.identity(),
        modelView = new Matrix4.identity();
    setPerspectiveMatrix(
      projection,
      45 * pi / 180,
      gl.canvas.clientWidth / gl.canvas.clientHeight,
      0.1,
      100.0,
    );
    modelView.translate(-0.0, 0.0, -6.0);

    webGLDraw(
      gl,
      program,
      vertexAtttributes: {
        0: {
          planeVertexShader.aVertexPosition: 2,
          planeVertexShader.aVertexColor: 2,
          //planeVertexShader.aVertexColor: 4,
        },
      },
      arrayBuffers: [positions, colors],
      //elementArrayBuffer: indices,
      drawType: TRIANGLE_STRIP,
      vertexCount: 4,
      uniformLocations: {
        planeVertexShader.uProjectionMatrix: projection,
        planeVertexShader.uModelViewMatrix: modelView,
      },
    );
  }
}
