package=gmp
$(package)_version=6.3.0
$(package)_download_path=https://ftp.gnu.org/gnu/gmp/
$(package)_file_name=$(package)-$($(package)_version).tar.bz2
$(package)_sha256_hash=ac28211a7cfb609bae2e2c8d6058d66c8fe96434f740cf6fe2e47b000d1c20cb
$(package)_patches=applem1.patch

define $(package)_set_vars
$(package)_config_opts+=--enable-cxx --enable-fat --with-pic --disable-shared
$(package)_cflags_armv7l_linux+=-march=armv7-a
$(package)_config_opts_arm_darwin+=--build=$(subst arm,aarch64,$(BUILD)) --host=$(subst arm,aarch64,$(HOST))
endef

define $(package)_config_cmds
  $($(package)_autoconf)
endef

define $(package)_preprocess_cmds
  patch -p1 <$($(package)_patch_dir)/applem1.patch
endef

define $(package)_build_cmds
  $(MAKE)
endef

define $(package)_stage_cmds
  $(MAKE) DESTDIR=$($(package)_staging_dir) install
endef

