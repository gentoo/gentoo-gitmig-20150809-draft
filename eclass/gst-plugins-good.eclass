# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/gst-plugins-good.eclass,v 1.28 2012/10/23 07:54:38 tetromino Exp $

# Author : foser <foser@gentoo.org>, zaheerm <zaheerm@gentoo.org>

# gst-plugins-good eclass
#
# eclass to make external gst-plugins emergable on a per-plugin basis
# to solve the problem with gst-plugins generating far too much unneeded deps
#
# 3rd party applications using gstreamer now should depend on a set of plugins as
# defined in the source, obtain recommended plugins to use from
# Gentoo developers responsible for gstreamer <gnome@gentoo.org>, the application developer
# or the gstreamer team.

inherit eutils versionator gst-plugins10

GST_EXPF="src_unpack src_compile src_install"
GST_TARBALL_SUFFIX="bz2"
GST_LA_PUNT="no"
case ${EAPI:-0} in
	4)	GST_EXPF="${GST_EXPF} src_configure"
		GST_TARBALL_SUFFIX="xz"
		GST_LA_PUNT="yes" ;;
	2|3) GST_EXPF="${GST_EXPF} src_configure" ;;
	1|0) ;;
	*) die "Unknown EAPI" ;;
esac
EXPORT_FUNCTIONS ${GST_EXPF}

###
# variable declarations
###

MY_PN=gst-plugins-good
MY_P=${MY_PN}-${PV}
# All relevant configure options for gst-plugins
# need a better way to extract these

# First line for non-plugin build related configure options; second line for
# sys/ plugins; rest is split plugin options in order of ./configure --help output.
# Good ways of validation are seeing diff of old and new configure.ac, and ./configure --help
#
# This list is current to gst-plugins-good-0.10.31:
my_gst_plugins_good="gconftool zlib bz2
directsound oss oss4 sunaudio osx_audio osx_video gst_v4l2 x xshm xvideo
aalib aalibtest annodex cairo esd esdtest flac gconf gdk_pixbuf hal jpeg
libcaca libdv libpng pulse dv1394 shout2 soup speex taglib wavpack"

# When adding conditionals like below, be careful about having leading spaces in concat

# --enable-shout2test option was removed in 0.10.31
if ! version_is_at_least "0.10.31"; then
	my_gst_plugins_good+=" shout2test"
fi

# cairooverlay added to the cairo plugin under cairo_gobject
if version_is_at_least "0.10.29"; then
	my_gst_plugins_good+=" cairo_gobject"
fi

# ext/jack moved here since 0.10.27
if version_is_at_least "0.10.27"; then
	my_gst_plugins_good+=" jack"
fi

#SRC_URI="mirror://gnome/sources/gst-plugins/${PV_MAJ_MIN}/${MY_P}.tar.bz2"
SRC_URI="http://gstreamer.freedesktop.org/src/gst-plugins-good/${MY_P}.tar.${GST_TARBALL_SUFFIX}"
[[ ${GST_TARBALL_SUFFIX} = "xz" ]] && DEPEND="${DEPEND} app-arch/xz-utils"

S=${WORKDIR}/${MY_P}
# added to remove circular deps
# 6/2/2006 - zaheerm
if [ "${PN}" != "${MY_PN}" ]; then
RDEPEND="=media-libs/gst-plugins-base-0.10*"
DEPEND="${RDEPEND}
	${DEPEND}
	>=sys-apps/sed-4
	virtual/pkgconfig"

# -good-0.10.24 uses orc optionally instead of liboil unconditionally.
# While <0.10.24 configure always checks for liboil, it is linked to only by non-split
# plugins in gst/, so we only builddep for all old packages, and have a RDEPEND in old
# versions of media-libs/gst-plugins-good
if ! version_is_at_least "0.10.24"; then
DEPEND="${DEPEND} >=dev-libs/liboil-0.3.8"
fi

RESTRICT=test
fi

###
# public functions
###

gst-plugins-good_src_configure() {

	# disable any external plugin besides the plugin we want
	local plugin gst_conf

	einfo "Configuring to build ${GST_PLUGINS_BUILD} plugin(s) ..."

	for plugin in ${my_gst_plugins_good}; do
		gst_conf="${gst_conf} --disable-${plugin} "
	done

	for plugin in ${GST_PLUGINS_BUILD}; do
		gst_conf="${gst_conf} --enable-${plugin} "
	done

	cd ${S}
	econf ${@} --with-package-name="Gentoo GStreamer Ebuild" --with-package-origin="http://www.gentoo.org" ${gst_conf} || die "./configure failure"

}

###
# public inheritable functions
###

gst-plugins-good_src_unpack() {

#	local makefiles

	unpack ${A}

	# Link with the syswide installed gst-libs if needed
#	gst-plugins10_find_plugin_dir
#	cd ${S}

	# Remove generation of any other Makefiles except the plugin's Makefile
#	if [ -d "${S}/sys/${GST_PLUGINS_BUILD_DIR}" ]; then
#		makefiles="Makefile sys/Makefile sys/${GST_PLUGINS_BUILD_DIR}/Makefile"
#	elif [ -d "${S}/ext/${GST_PLUGINS_BUILD_DIR}" ]; then
#		makefiles="Makefile ext/Makefile ext/${GST_PLUGINS_BUILD_DIR}/Makefile"
#	fi
#	sed -e "s:ac_config_files=.*:ac_config_files='${makefiles}':" \
#		-i ${S}/configure

}

gst-plugins-good_src_compile() {

	has src_configure ${GST_EXPF} || gst-plugins-good_src_configure ${@}

	gst-plugins10_find_plugin_dir
	emake || die "compile failure"

}

gst-plugins-good_src_install() {

	gst-plugins10_find_plugin_dir
	einstall || die
	[[ ${GST_LA_PUNT} = "yes" ]] && prune_libtool_files --modules

	[[ -e README ]] && dodoc README
}
