# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/gst-plugins/gst-plugins-0.6.0-r1.ebuild,v 1.4 2003/02/18 12:37:35 raker Exp $

inherit eutils libtool gnome2 flag-o-matic

# Create a major/minor combo for our SLOT and executables suffix
PVP=($(echo " $PV " | sed 's:[-\._]: :g'))
PV_MAJ_MIN=${PVP[0]}.${PVP[1]}

IUSE="encode quicktime mpeg jpeg esd gnome mikmod sdl png alsa arts dvd aalib"

S="${WORKDIR}/${P}"
DESCRIPTION="Additional plugins for gstreamer - streaming media framework"
HOMEPAGE="http://gstreamer.sourceforge.net"

SLOT=${PV_MAJ_MIN}
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~sparc ~ppc"

# required packages
# there are many many optional libraries. features are compiled if the libraries
# are present. most optional libraries are from gnome.
DEPEND="=media-libs/gstreamer-${PV}*
	>=gnome-base/gconf-1.2.0
	media-sound/mad
	media-libs/flac
	media-sound/cdparanoia
	media-libs/hermes
	>=media-libs/libdv-0.9.5
	media-libs/libvorbis
	media-libs/libogg
	encode? ( media-sound/lame )
	quicktime? ( media-libs/openquicktime )
	mpeg? (	>=media-libs/libmpeg2-0.3.1 )
	jpeg? (	media-video/mjpegtools 
	mmx? ( >=media-libs/jpeg-mmx-1.1.2-r1 ) )
	esd? ( media-sound/esound )
	gnome? ( >=gnome-base/gnome-vfs-2.0.1 )
	mikmod? ( media-libs/libmikmod )
	sdl? ( media-libs/libsdl )
	png? ( >=media-libs/libpng-1.2.3 )
	alsa? ( >=media-libs/alsa-lib-0.9.0_rc2 virtual/jack )
	arts? ( >=kde-base/arts-1.0.2 )
	dvd? ( 	media-libs/libdvdnav )
	aalib? ( media-libs/aalib )
	media-libs/ladspa-sdk" 

# oggvorbis now is used by the cvs of ffmpeg
#	oggvorbis? ( media-libs/libvorbis 
#	             media-libs/libogg )


src_unpack() {
	unpack ${A}

	# ffmpeg libs fix
	epatch ${FILESDIR}/${PN}-${PV_MAJ_MIN}-ffmpeg_ldflags.patch

	# fix the scripts
	cd ${S}/tools
	mv gst-launch-ext gst-launch-ext.old
	sed -e "s:gst-launch :gst-launch-${PV_MAJ_MIN} :" \
		-e "s:gst-launch-ext:gst-launch-ext-${PV_MAJ_MIN}:" gst-launch-ext.old > gst-launch-ext
	chmod +x gst-launch-ext

	mv gst-visualise gst-visualise.old
	sed -e "s:gst-launch :gst-launch-${PV_MAJ_MIN} :" \
		-e "s:gst-visualise:gst-visualise-${PV_MAJ_MIN}:" gst-visualise.old > gst-visualise
	chmod +x gst-visualise
}

src_compile() {
	elibtoolize

	# gst doesnt handle optimisations well
	strip-flags
	replace-flags "-O3" "-O2"

	local myconf=""

	# FIXME : do this for _all_ IUSE flags
#	use avi \
#		&& myconf="${myconf} --enable-avifile" \
#		|| myconf="${myconf} --disable-avifile"
		myconf="${myconf} --enable-avifile"
	use aalib \
		&& myconf="${myconf} --enable-aalib" \
		|| myconf="${myconf} --disable-aalib"
	use dvd \
		&& myconf="${myconf} --enable-dvdread --enable-dvdnav \
		                     --enable-libdv" \
		|| myconf="${myconf} --disable-dvdread --disable-dvdnav \
		                     --disable-libdv"
	use esd \
		&& myconf="${myconf} --enable-esd --enable-esdtest" \
		|| myconf="${myconf} --disable-esd --disable-esdtest"
	use gnome \
		&& myconf="${myconf} --enable-gnome_vfs" \
		|| myconf="${myconf} --disable-gnome_vfs"
	use encode \
		&& myconf="${myconf} --enable-lame" \
		|| myconf="${myconf} --disable-lame"
	use quicktime \
		&& myconf="${myconf} --enable-openquicktime" \
		|| myconf="${myconf} --disable-openquicktime"
	use mpeg \
		&& myconf="${myconf} --enable-mpeg2dec" \
		|| myconf="${myconf} --disable-mpeg2dec"
#	use oggvorbis \
#		&& myconf="${myconf} --enable-vorbis --enable-vorbistest" \
#		|| myconf="${myconf} --disable-vorbis --disable-vorbistest"		
	myconf="${myconf} --enable-vorbis --enable-vorbistest" 
	 
	# qcam doesn't work on PPC
	use ppc && myconf="${myconf} --disable-qcam"
	
	econf ${myconf} \
		--program-suffix=-${PV_MAJ_MIN} \
		|| die "./configure failed"
		
	emake || make || die
}

src_install () {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"		
	make DESTDIR=${D} install || die
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL

	dodoc AUTHORS COPYING INSTALL README RELEASE TODO 
}

pkg_postinst () {
	gnome2_gconf_install
	gst-register-${PV_MAJ_MIN}
}
