# TODO: Refactor so pretty

output = SCL
so_dir = /usr/lib
so_compile_files = src/*.cpp
hpp_dir = /usr/include
hpp_files = src/*.hpp
compiler = clang++
compiler_flags = -std=c++11 -shared -fPIC -o lib$(output).so

help:
	@echo "make help"
	@echo "make install"
	@echo "make uninstall"

install:
	@if [ ! -d $(so_dir) ]; then mkdir -p $(so_dir); fi
	@$(compiler) $(compiler_flags) $(so_compile_files)
	@mv lib$(output).so $(so_dir)
	@if [ ! -d $(hpp_dir)/$(output) ]; then mkdir -p $(hpp_dir)/$(output); fi
	@cp $(hpp_files) $(hpp_dir)/$(output)
	@ldconfig

uninstall:
	@if [ -f $(so_dir)/lib$(output).so ]; then \
		rm $(so_dir)/lib$(output).so; \
		echo "Uninstalled $(output) from $(so_dir)"; \
	else \
		echo "$(output) is not installed in $(so_dir)"; \
	fi
	@if [ -d $(hpp_dir)/$(output) ]; then rm -r $(hpp_dir)/$(output); fi
	@ldconfig

.PHONY: help install uninstall
