# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/gst-plugins.eclass,v 1.1 2003/06/16 22:04:56 foser Exp $

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

# accept both $DEBUG and USE="debug"
[ -n "$DEBUG" -o -n "`use debug`" ] && inherit debug

# Create a major/minor combo for our SLOT and executables suffix

PVP=($(echo " $PV " | sed 's:[-\._]: :g'))
PV_MAJ_MIN=${PVP[0]}.${PVP[1]}

MY_P=gst-plugins-${PV}

# All relevant configure options for gst-plugins

my_gst_plugins="dxr3 oss qcam v4l v4l2 vcd vga cdrom xvideo a52dec aalib aalibtest alsa arts artstest artsc audiofile avifile cdparanoia dvdread dvdnav esd esdtest flac ffmpeg gnome_vfs gsm hermes http jack jpeg ladspa lame lcs libdv libfame libfametest libpng mad mikmod libmikmodtest mjpegtools mpeg2dec openquicktime raw1394 rtp sdl sdltest shout shout2 shout2test sidplay smoothwave snapshot swfdec tarkin vorbis vorbistest xmms libmmx atomic tests examples" 

#
# Extract the plugin to build from the ebuild name
#

BUILD_GST_PLUGIN=${PN/gst-plugins-/}

#
# general common gst-plugins ebuild entries 
#

DESCRIPTION="${BUILD_GST_PLUGIN} plugin for gstreamer"
HOMEPAGE="http://www.gstreamer.net/status/"
LICENSE="GPL-2"

SRC_URI="mirror://gnome/sources/gst-plugins/${PV_MAJ_MIN}/${MY_P}.tar.bz2"
SLOT=${PV_MAJ_MIN}

S=${WORKDIR}/${MY_P}

newdepend "=${MY_P}*"

#
# public functions
#

gst-plugins_src_configure() {
	
	elibtoolize ${ELTCONF}

	#
	# disable any external plugin besides the plugin we want
	#

	local plugin gst_conf

	einfo "${BUILD_GST_PLUGIN}"
	for plugin in ${my_gst_plugins}; do
		if [ ${plugin} = ${BUILD_GST_PLUGIN} ];
		then
			einfo "Building ${plugin} plugin(s)..."
			gst_conf="${gst_conf} --enable-${plugin} "
		else
			gst_conf="${gst_conf} --disable-${plugin} "
		fi
	done

	econf ${@} ${gst_conf} || die "./configure failure"

}

#
# public inheritable functions
#

gst-plugins_src_compile() {

	gst-plugins_src_configure ${@}

	cd ${S}/ext/${BUILD_GST_PLUGIN}
	emake || die "compile failure"

}

gst-plugins_src_install() {

	cd ${S}/ext/${BUILD_GST_PLUGIN}
	einstall || die

	dodoc README
}


gst-plugins_pkg_postinst() {

	einfo "Updating gstreamer plugins registry..."
	gst-register-${SLOT}

}

gst-plugins_pkg_postrm() {

	einfo "Updating gstreamer plugins registry..."
	gst-register-${SLOT}

}


EXPORT_FUNCTIONS src_compile src_install pkg_postinst pkg_postrm
