# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/gst-plugins.eclass,v 1.5 2004/01/09 02:19:04 liquidx Exp $

# Author : foser <foser@gentoo.org>

# gst-plugins eclass
#
# eclass to make external gst-plugins emergable on a per-plugin basis
# to solve the problem with gst-plugins generating far too much unneeded deps
#
# 3rd party applications using gstreamer now should depend on a set of plugins as 
# defined in the source, in case of spider usage obtain recommended plugins to use from 
# Gentoo developers responsible for gstreamer <gnome@gentoo.org>, the application developer 
# or the gstreamer team.

ECLASS="gst-plugins"
INHERITED="$INHERITED $ECLASS"

inherit libtool
[ `use debug` ] && inherit debug

#
# variable declarations
#

# Create a major/minor combo for our SLOT and executables suffix

PVP=($(echo " $PV " | sed 's:[-\._]: :g'))
PV_MAJ_MIN=${PVP[0]}.${PVP[1]}

MY_P=gst-plugins-${PV}

# All relevant configure options for gst-plugins

my_gst_plugins="dxr3 oss qcam v4l v4l2 vcd vga cdrom xvideo a52dec aalib aalibtest alsa arts artstest artsc audiofile avifile cdparanoia dvdread dvdnav esd esdtest flac ffmpeg gnome_vfs gsm hermes http jack jpeg ladspa lame lcs libdv libfame libfametest libpng mad mikmod libmikmodtest mjpegtools mpeg2dec openquicktime raw1394 rtp sdl sdltest shout shout2 shout2test sidplay smoothwave snapshot swfdec tarkin vorbis vorbistest xmms libmmx atomic tests examples" 

# Extract the plugin to build from the ebuild name
# May be set by an ebuild and contain more than one indentifier, seperated by a space

BUILD_GST_PLUGINS=${PN/gst-plugins-/}

# Actual build dir, is the same as the configure switch name most of the time

GST_PLUGINS_BUILD_DIR=${PN/gst-plugins-/}

# general common gst-plugins ebuild entries 

DESCRIPTION="${BUILD_GST_PLUGINS} plugin for gstreamer"
HOMEPAGE="http://www.gstreamer.net/status/"
LICENSE="GPL-2"

SRC_URI="mirror://gnome/sources/gst-plugins/${PV_MAJ_MIN}/${MY_P}.tar.bz2"
SLOT=${PV_MAJ_MIN}

S=${WORKDIR}/${MY_P}

newdepend "=${MY_P}*" ">=sys-apps/sed-4"

#
# internal functions
#

gst-plugins_find_plugin_dir() {

	if [ ! -d ${S}/ext/${GST_PLUGINS_BUILD_DIR} ]; then
		if [ ! -d ${S}/sys/${GST_PLUGINS_BUILD_DIR} ]; then
			ewarn "No such plugin directory"
			die
		fi
		einfo "Building system plugin..."
		cd ${S}/sys/${GST_PLUGINS_BUILD_DIR}
	else
		einfo "Building external plugin..."
		cd ${S}/ext/${GST_PLUGINS_BUILD_DIR}
	fi

}

#
# public functions
#

gst-plugins_src_configure() {
	
	elibtoolize ${ELTCONF}

	#
	# disable any external plugin besides the plugin we want
	#

	local plugin gst_conf

	einfo "Configuring to build ${BUILD_GST_PLUGINS} plugin(s)..."
	for plugin in ${my_gst_plugins}; do
		if [ ${plugin} = ${BUILD_GST_PLUGINS} ];
		then
			gst_conf="${gst_conf} --enable-${plugin} "
		else
			gst_conf="${gst_conf} --disable-${plugin} "
		fi
	done

	econf ${@} ${gst_conf} || die "./configure failure"

}

gst-plugins_update_registry() {

	einfo "Updating gstreamer plugins registry for gstreamer ${SLOT}..."
	gst-register-${SLOT}

}

#
# public inheritable functions
#

gst-plugins_src_unpack() {
	local makefiles
	unpack ${A}
	#
	# Remove generation of any other Makefiles except the plugin's Makefile
	#
	if [ -d "${S}/sys/${GST_PLUGINS_BUILD_DIR}" ]; then
		makefiles="Makefile sys/Makefile sys/${GST_PLUGINS_BUILD_DIR}/Makefile"
	elif [ -d "${S}/ext/${GST_PLUGINS_BUILD_DIR}" ]; then
		makefiles="Makefile ext/Makefile ext/${GST_PLUGINS_BUILD_DIR}/Makefile"
	fi
	sed -e "s:ac_config_files=.*:ac_config_files='${makefiles}':" \
		-i ${S}/configure
}

gst-plugins_src_compile() {

	gst-plugins_src_configure ${@}

	gst-plugins_find_plugin_dir
	emake || die "compile failure"

}

gst-plugins_src_install() {

	gst-plugins_find_plugin_dir
	einstall || die

	dodoc README
}


gst-plugins_pkg_postinst() {

	gst-plugins_update_registry

}

gst-plugins_pkg_postrm() {

	gst-plugins_update_registry

}

EXPORT_FUNCTIONS src_unpack src_compile src_install pkg_postinst pkg_postrm
