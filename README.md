## Current Flow

GitHub repository
        |
        V
GitHub-hosted Ubuntu runner
        |
        V
Docker image containing:
  - Verilator
  - UVM library
  - GCC/Clang
  - Make
  - Python utilities
        |
        V
Compile and run UVM tests

