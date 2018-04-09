import 'dart:web_gl';

/// Represents a GLSL shader that statically knows the locations of its variables and uniforms.
class GLSL {
  /// The GLSL source text.
  final String source;

  /// The type of shader.
  ///
  /// Either [VERTEX_SHADER] or [FRAGMENT_SHADER].
  final int shaderType;

  RenderingContext _context;
  Program _program;
  Shader _shader;

  GLSL(this.source, this.shaderType);

  /// The [RenderingContext] that compiled this [shader].
  RenderingContext get context {
    if (_context != null) return _context;
    throw new StateError('The shader has not yet been compiled.');
  }

  /// The [Program] that compiled this [shader].
  Program get program {
    if (_program != null) return _program;
    throw new StateError('The shader has not yet been compiled.');
  }

  /// The compiled WebGL [Shader].
  Shader get shader => _shader;

  /// Compiles this shader within the context of a [Program].
  void compile(RenderingContext context, Program program) {
    if (_shader != null) {
      _context = context;
      _program = program;
      _shader = context.createShader(shaderType);
      context.shaderSource(_shader, source);
      context.compileShader(_shader);
      context.attachShader(program, _shader);
    }
  }
}
