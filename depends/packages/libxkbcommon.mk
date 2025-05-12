package=libxkbcommon
$(package)_version=1.9.2
$(package)_download_path=https://github.com/xkbcommon/libxkbcommon/archive/
$(package)_file_name=xkbcommon-$($(package)_version).tar.gz
$(package)_sha256_hash=8d68a8b45796f34f7cace357b9f89b8c92b158557274fef5889b03648b55fe59
$(package)_dependencies=libxcb

# This package explicitly enables -Werror=array-bounds, which causes build failures
# with GCC 12.1+. Work around that by turning errors back into warnings.
# This workaround would be dropped if the package was updated, as that would require
# a different build system (Meson)
define $(package)_set_vars
$(package)_config_opts = --enable-option-checking --disable-dependency-tracking
$(package)_config_opts += --disable-docs
$(package)_cflags += -Wno-error=array-bounds
endef

define $(package)_preprocess_cmds
  cp -f $(BASEDIR)/config.guess $(BASEDIR)/config.sub build-aux
endef

define $(package)_config_cmds
  $($(package)_autoconf)
endef

define $(package)_build_cmds
  $(MAKE)
endef

define $(package)_stage_cmds
  $(MAKE) DESTDIR=$($(package)_staging_dir) install
endef

define $(package)_postprocess_cmds
  rm lib/*.la
endef

