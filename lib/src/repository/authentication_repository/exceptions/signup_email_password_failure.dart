import '';

class SignUpWithEmailAndPasswordFailure {
  final String message;

  const SignUpWithEmailAndPasswordFailure([this.message = "An Unknown error has occurred."]);

  factory SignUpWithEmailAndPasswordFailure.code(String code) {
    switch(code) {
      case 'weak-password' :
        return const SignUpWithEmailAndPasswordFailure('Please enter a stronger password.');
      case 'invalid-email' :
        return const SignUpWithEmailAndPasswordFailure('Please enter a valid email.');
      case 'email-already-in-use' :
        return const SignUpWithEmailAndPasswordFailure('An account already exists for the give email.');
      case 'operation-not-allowed' :
        return const SignUpWithEmailAndPasswordFailure('Operation now allowed. Please contact support.');
      case 'user-disabled' :
        return const SignUpWithEmailAndPasswordFailure('This user has been disabled. Please contact support.');

      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}