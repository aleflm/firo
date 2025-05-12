package=native_cmake
$(package)_version=4.0.2
$(package)_download_path=https://cmake.org/files/v4.0/
$(package)_file_name=cmake-$($(package)_version).tar.gz
$(package)_sha256_hash=1c3a82c8ca7cf12e0b17178f9d0c32f7ac773bd5651a98fcfd80fbf4977f8d48

define $(package)_set_vars
  $(package)_config_opts=
endef

define $(package)_config_cmds
  ./bootstrap --prefix=$(build_prefix)
endef

define $(package)_build_cmds
  $(MAKE)
endef

define $(package)_stage_cmds
  $(MAKE) DESTDIR=$($(package)_staging_dir) install
endef
