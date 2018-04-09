import 'dart:typed_data';
import 'dart:web_gl';
import 'package:meta/meta.dart';
import 'package:vector_math/vector_math.dart';

/// Shorthand WebGL drawing function.
void webGLDraw(
  RenderingContext gl,
  Program program, {

  /// Any vertex attributes to have their values set.
  Map<int, int> vertexAtttributes = const {},

  /// Normalization of [vertexAttributes].
  bool normalized = false,

  /// Stride of [vertexAttributes].
  int stride = 0,

  /// Offset of [vertexAttributes].
  int offset = 0,

  /// Buffers of [double]s to be bound as [ARRAY_BUFFER] and [STATIC_DRAW].
  List<List<double>> arrayBuffers = const [],

  /// Buffers of [int]s to be bound as [ELEMENT_ARRAY_BUFFER] and [STATIC_DRAW].
  @required List<int> elementArrayBuffer,

  /// The WebGL draw type.
  int drawType = TRIANGLES,

  /// Any uniforms to be filled.
  Map<UniformLocation, Matrix4> uniformLocations,
}) {

  // Set all vertex attributes.
  vertexAtttributes.forEach((attrib, value) {
    gl
      ..vertexAttribPointer(attrib, value, FLOAT, normalized, stride, offset)
      ..enableVertexAttribArray(attrib);
  });

  // Bind and fill all array buffers.
  for (var buf in arrayBuffers) {
    var buffer = gl.createBuffer();
    gl
      ..bindBuffer(ARRAY_BUFFER, buffer)
      ..bufferData(ARRAY_BUFFER, new Float32List.fromList(buf), STATIC_DRAW);
  }

  // Apply any uniform location.
  uniformLocations.forEach((uniform, matrix) {
    var list = new Float32List(16);
    matrix.copyIntoArray(list);
    gl.uniformMatrix4fv(uniform, false, list);
  });

  // Bind and fill the element array buffer.
  var buffer = gl.createBuffer();
  gl
    ..bindBuffer(ELEMENT_ARRAY_BUFFER, buffer)
    ..bufferData(ELEMENT_ARRAY_BUFFER,
        new Uint16List.fromList(elementArrayBuffer), STATIC_DRAW);

  // Finally, draw the elements.
  gl.drawElements(drawType, elementArrayBuffer.length, UNSIGNED_SHORT, 0);
}
