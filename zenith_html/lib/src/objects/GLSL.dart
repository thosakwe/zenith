import 'dart:web_gl';

/// Represents a GLSL shader that statically knows the locations of its variables and uniforms.
class GLSL {
  /// The GLSL source text.
  final String source;

  /// The type of shader.
  ///
  /// Either [VERTEX_SHADER] or [FRAGMENT_SHADER].
  final int shaderType;

  Shader _shader;

  GLSL(this.source, this.shaderType);

  Shader get shader => _shader;

  /// Compiles this shader within the context of a [Program].
  void compile(RenderingContext ctx, Program program) {
    if (_shader != null) {
      _shader = ctx.createShader(shaderType);
      ctx.shaderSource(_shader, source);
      ctx.compileShader(_shader);
      ctx.attachShader(program, _shader);
    }
  }
}
