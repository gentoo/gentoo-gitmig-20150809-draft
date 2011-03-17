# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/gst-plugins-ugly.eclass,v 1.22 2011/03/17 21:12:40 nirbheek Exp $

# Author : foser <foser@gentoo.org>

# gst-plugins-ugly eclass
#
# eclass to make external gst-plugins emergable on a per-plugin basis
# to solve the problem with gst-plugins generating far too much unneeded deps
#
# 3rd party applications using gstreamer now should depend on a set of plugins as
# defined in the source, in case of spider usage obtain recommended plugins to use from
# Gentoo developers responsible for gstreamer <gnome@gentoo.org>, the application developer
# or the gstreamer team.

inherit eutils versionator gst-plugins10


###
# variable declarations
###

MY_PN=gst-plugins-ugly
MY_P=${MY_PN}-${PV}
# All relevant configure options for gst-plugins-ugly
# need a better way to extract these.
my_gst_plugins_ugly="a52dec amrnb amrwb cdio dvdread lame mad mpeg2dec sidplay
twolame x264"

# dvdnav and id3tag disabled/removed since -ugly-0.10.13
if ! version_is_at_least "0.10.13"; then
	my_gst_plugins_bad+=" dvdnav id3tag"
fi

GST_UGLY_EXPORTED_FUNCTIONS="src_unpack src_compile src_install"

case "${EAPI:-0}" in
	0)
		if [[ -n ${GST_ORC} ]]; then
			die "Usage of IUSE=+orc implying GST_ORC variable without EAPI-1"
		fi
		;;
	1)
		;;
	*)
		die "Unsupported EAPI ${EAPI}"
		;;
esac

# exports must be ALWAYS after inherit
EXPORT_FUNCTIONS ${GST_UGLY_EXPORTED_FUNCTIONS}

if version_is_at_least "0.10.16"; then
	# Ensure GST_ORC is set to a default. This fact is also relied on in
	# gst-plugins-ugly_src_configure, signalling it's >=0.10.16 and has orc options
	GST_ORC=${GST_ORC:-"no"}
	if [[ ${GST_ORC} == "yes" ]]; then
		IUSE="+orc"
	fi
else
	unset GST_ORC
fi

#SRC_URI="mirror://gnome/sources/gst-plugins/${PV_MAJ_MIN}/${MY_P}.tar.bz2"
SRC_URI="http://gstreamer.freedesktop.org/src/gst-plugins-ugly/${MY_P}.tar.bz2"

S=${WORKDIR}/${MY_P}

if [[ ${GST_ORC} == "yes" ]]; then
	RDEPEND="orc? ( >=dev-lang/orc-0.4.6 )"
	DEPEND="${RDEPEND}"
fi

# added to remove circular deps
# 6/2/2006 - zaheerm
if [ "${PN}" != "${MY_PN}" ]; then
RDEPEND="${RDEPEND}
	=media-libs/gst-plugins-base-0.10*"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	dev-util/pkgconfig"

# -ugly-0.10.16 uses orc optionally instead of liboil unconditionally.
# While <0.10.16 configure always checks for liboil, it is linked to only by a52dec,
# so we only builddep for all packages, and have a RDEPEND in old gst-plugins-a52dec
if ! version_is_at_least "0.10.16"; then
DEPEND="${DEPEND} >=dev-libs/liboil-0.3.8"
fi

RESTRICT=test
fi

###
# public functions
###

gst-plugins-ugly_src_configure() {

	# disable any external plugin besides the plugin we want
	local plugin gst_conf gst_orc_conf

	einfo "Configuring to build ${GST_PLUGINS_BUILD} plugin(s) ..."

	for plugin in ${my_gst_plugins_ugly}; do
		gst_conf="${gst_conf} --disable-${plugin} "
	done

	for plugin in ${GST_PLUGINS_BUILD}; do
		gst_conf="${gst_conf} --enable-${plugin} "
	done

	gst_orc_conf=""
	if [[ -n ${GST_ORC} ]]; then
		if [[ ${GST_ORC} == "yes" ]]; then
			gst_orc_conf="$(use_enable orc)"
		else
			gst_orc_conf="--disable-orc"
		fi
	fi
	#else leave gst_orc_conf empty, as $PV is less than 0.10.16, so no --enable/disable-orc yet

	cd ${S}
	econf ${gst_orc_conf} ${@} --with-package-name="Gentoo GStreamer Ebuild" --with-package-origin="http://www.gentoo.org" ${gst_conf} || die "./configure failure"

}

###
# public inheritable functions
###

gst-plugins-ugly_src_unpack() {

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

gst-plugins-ugly_src_compile() {

	gst-plugins-ugly_src_configure ${@}

	gst-plugins10_find_plugin_dir
	emake || die "compile failure"

}

gst-plugins-ugly_src_install() {

	gst-plugins10_find_plugin_dir
	einstall || die

	[[ -e README ]] && dodoc README
}
