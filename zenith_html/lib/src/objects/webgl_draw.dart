import 'dart:typed_data';
import 'dart:web_gl';
import 'package:meta/meta.dart';
import 'package:tuple/tuple.dart';
import 'package:vector_math/vector_math.dart';

/// Shorthand WebGL drawing function.
void webGLDraw(
  RenderingContext gl,
  Program program, {

  /// A [Map] of the indices of [arrayBuffers] to any vertex attributes to have their values set.
  Map<int, Map<int, int>> vertexAtttributes = const {},

  /// Normalization of [vertexAttributes].
  bool normalized = false,

  /// Stride of [vertexAttributes].
  int stride = 0,

  /// Offset of [vertexAttributes].
  int offset = 0,

  /// Buffers of [double]s to be bound as [ARRAY_BUFFER] and [STATIC_DRAW].
  List<List<double>> arrayBuffers = const [],

  /// Buffers of [int]s to be bound as [ELEMENT_ARRAY_BUFFER] and [STATIC_DRAW].
  List<int> elementArrayBuffer,

  /// The WebGL draw type.
  int drawType = TRIANGLES,

  /// How many vertices to draw if calling `drawArrays`.
  int vertexCount,

  /// Any uniforms to be filled.
  Map<UniformLocation, Matrix4> uniformLocations,
}) {

  // Bind and fill all array buffers.
  var buffers = <Buffer>[];
  int arrayOffset = 0; //elementArrayBuffer == null ? 1 : 0;

  for (int i = arrayOffset; i < arrayBuffers.length; i++) {
    var buffer = gl.createBuffer();
    buffers.add(buffer);
    gl
      ..bindBuffer(ARRAY_BUFFER, buffer)
      ..bufferData(
          ARRAY_BUFFER, new Float32List.fromList(arrayBuffers[i]), STATIC_DRAW);
  }

  // Set all vertex attributes.
  vertexAtttributes.forEach((index, map) {
    gl.bindBuffer(ARRAY_BUFFER, buffers[index]);
    map.forEach((attrib, value) {
      gl
        ..vertexAttribPointer(attrib, value, FLOAT, normalized, stride, offset)
        ..enableVertexAttribArray(attrib);
    });
  });

  gl.useProgram(program);

  // Apply any uniform location.
  uniformLocations.forEach((uniform, matrix) {
    var list = new Float32List(16);
    matrix.copyIntoArray(list);
    gl.uniformMatrix4fv(uniform, false, list);
  });

  if (elementArrayBuffer != null) {
    // Bind and fill the element array buffer.
    var buffer = gl.createBuffer();
    gl
      ..bindBuffer(ELEMENT_ARRAY_BUFFER, buffer)
      ..bufferData(ELEMENT_ARRAY_BUFFER,
          new Uint16List.fromList(elementArrayBuffer), STATIC_DRAW);

    // Finally, draw the elements.
    gl.drawElements(drawType, elementArrayBuffer.length, UNSIGNED_SHORT, 0);
  } else {
    // Draw the first array buffer.
    /*var buffer = gl.createBuffer();
    gl
      ..bindBuffer(ARRAY_BUFFER, buffer)
      ..bufferData(
          ARRAY_BUFFER, new Float32List.fromList(arrayBuffers[0]), STATIC_DRAW)
      ..bindBuffer(ARRAY_BUFFER, buffer);*/
    gl.drawArrays(drawType, offset, vertexCount);
  }
}
