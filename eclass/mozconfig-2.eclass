# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/mozconfig-2.eclass,v 1.7 2005/12/06 01:50:11 anarchy Exp $
#
# mozconfig.eclass: the new mozilla.eclass

inherit multilib flag-o-matic mozcoreconf

IUSE="debug gnome ipv6 xinerama xprint mozsvg"

RDEPEND=">=media-libs/jpeg-6b
	>=media-libs/libmng-1.0.0
	>=media-libs/libpng-1.2.1
	dev-libs/expat
	app-arch/zip
	app-arch/unzip
	>=www-client/mozilla-launcher-1.42
	>=x11-libs/gtk+-2.8.6
	>=dev-libs/glib-2.8.2
	>=x11-libs/pango-1.10.1
	>=dev-libs/libIDL-0.8.0
	gnome? ( >=gnome-base/gnome-vfs-2.3.5 
		 >=gnome-base/libgnomeui-2.2.0 )
	mozsvg? ( !<x11-base/xorg-x11-6.7.0-r2
		    >=x11-libs/cairo-1.0.0)"

mozconfig_config() {
	mozconfig_use_enable ipv6
	mozconfig_use_enable xinerama
	mozconfig_use_enable xprint

	# We use --enable-pango to do truetype fonts, and currently pango
	# is required for it to build
	mozconfig_annotate gentoo --disable-freetype2

	if use debug; then
		mozconfig_annotate +debug \
			--enable-debug \
			--enable-tests \
			--disable-reorder \
			--disable-strip \
			--disable-strip-libs \
			--enable-debugger-info-modules=ALL_MODULES
	else
		mozconfig_annotate -debug \
			--disable-debug \
			--disable-tests \
			--enable-reorder \
			--enable-strip \
			--enable-strip-libs

		# Currently --enable-elf-dynstr-gc only works for x86 and ppc,
		# thanks to Jason Wever <weeve@gentoo.org> for the fix.
		if use x86 || use ppc && [[ ${enable_optimize} != -O0 ]]; then
			mozconfig_annotate "${ARCH} optimized build" --enable-elf-dynstr-gc
		fi
	fi

	if ! use gnome; then
		mozconfig_annotate -gnome --disable-gnomevfs
		mozconfig_annotate -gnome --disable-gnomeui
 	fi

	if use mozsvg; then
		mozconfig_annotate mozsvg --enable-svg
		mozconfig_annotate mozsvg --enable-svg-renderer=cairo
	fi
}
