# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gst-plugins/gst-plugins-0.6.2-r1.ebuild,v 1.6 2004/03/19 07:56:03 mr_bones_ Exp $

inherit eutils libtool gnome2 flag-o-matic

# Create a major/minor combo for our SLOT and executables suffix
PVP=($(echo " $PV " | sed 's:[-\._]: :g'))
PV_MAJ_MIN=${PVP[0]}.${PVP[1]}

DESCRIPTION="Additional plugins for gstreamer - streaming media framework"
HOMEPAGE="http://gstreamer.sourceforge.net"

LICENSE="LGPL-2.1"
SLOT=${PV_MAJ_MIN}
KEYWORDS="x86 ~sparc ppc ~amd64"
IUSE="encode quicktime mpeg jpeg esd gnome mikmod sdl png alsa arts dvd aalib oggvorbis mmx"

# required packages
# there are many many optional libraries. features are compiled if the libraries
# are present. most optional libraries are from gnome.

# TODO: I think we should split up these plugins in seperate ebuilds

RDEPEND="=media-libs/gstreamer-${PV}*
	>=gnome-base/gconf-1.2

	media-sound/mad
	media-libs/hermes
	media-sound/cdparanoia

	oggvorbis? ( media-libs/libvorbis
		media-libs/libogg )
	encode? ( media-sound/lame )
	quicktime? ( media-libs/openquicktime )
	mpeg? (	>=media-libs/libmpeg2-0.3.1 )
	esd? ( media-sound/esound )
	gnome? ( >=gnome-base/gnome-vfs-2.0.1 )
	mikmod? ( media-libs/libmikmod )
	sdl? ( media-libs/libsdl )
	jpeg? ( media-libs/jpeg )
	png? ( >=media-libs/libpng-1.2.3 )
	alsa? ( >=media-libs/alsa-lib-0.9.0_rc2 )
	arts? ( >=kde-base/arts-1.0.2 )
	dvd? ( 	media-libs/libdvdnav
		media-libs/libdvdread )
	aalib? ( media-libs/aalib )"

# Some ditched minor plugins to bring number of deps down
#	>=media-libs/flac-1.0.3
#	virtual/jack
#	media-libs/ladspa-sdk"
#	>=media-libs/libdv-0.9.5

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	sys-devel/automake"

src_unpack() {
	unpack ${A}
	cd ${S}
	# ppc asm included in the resample plugin seems to be broken,
	# using a slower but working version for now
	epatch ${FILESDIR}/noppcasm.patch

	# patch for gcc-3.3.x
	cd ${S};  patch -p1 < ${FILESDIR}/${PN}-0.6.3-gcc33.patch

	# ffmpeg libs fix
	use oggvorbis && epatch ${FILESDIR}/${PN}-${PV_MAJ_MIN}-ffmpeg_ldflags.patch

	# patch for changing types in >libmpeg-0.3.1
	if grep -q mpeg2_picture ${ROOT}/usr/include/mpeg2dec/mpeg2.h; then
		epatch ${FILESDIR}/libmpeg2.patch
	fi

	# remove problematic default CFLAGS (#22249)
	epatch ${FILESDIR}/${P}-rm_cflags.patch

	automake || die

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
	use aalib \
		&& myconf="${myconf} --enable-aalib" \
		|| myconf="${myconf} --disable-aalib"
	use dvd \
		&& myconf="${myconf} --enable-dvdread --enable-dvdnav" \
		|| myconf="${myconf} --disable-dvdread --disable-dvdnav"
	use esd \
		&& myconf="${myconf} --enable-esd" \
		|| myconf="${myconf} --disable-esd"
	use alsa \
		&& myconf="${myconf} --enable-alsa" \
		|| myconf="${myconf} --disable-alsa"
	use arts \
		&& myconf="${myconf} --enable-arts --enable-artsc" \
		|| myconf="${myconf} --disable-arts --disable-artsc"
	use encode \
		&& myconf="${myconf} --enable-lame" \
		|| myconf="${myconf} --disable-lame"
	use jpeg \
		&& myconf="${myconf} --enable-jpeg" \
		|| myconf="${myconf} --disable-jpeg"
	use jpeg && use mmx \
		&& myconf="${myconf} --enable-mjpegtools" \
		|| myconf="${myconf} --disable-mjpegtools"
	use png \
		&& myconf="${myconf} --enable-png" \
		|| myconf="${myconf} --disable-png"
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
	use sdl \
		&& myconf="${myconf} --enable-sdl --enable-sdltest" \
		|| myconf="${myconf} --disable-sdl --disable-sdltest"
	use oggvorbis \
		&& myconf="${myconf} --enable-vorbis --enable-vorbistest" \
		|| myconf="${myconf} --disable-vorbis --disable-vorbistest"
	use mikmod \
		&& myconf="${myconf} --enable-mikmod --enable-libmikmodtest" \
		|| myconf="${myconf} --disable-mikmod --disable-libmikmodtest"

	# qcam doesn't work on PPC
	use ppc && myconf="${myconf} --disable-qcam"

	econf ${myconf} \
		--program-suffix=-${PV_MAJ_MIN} \
		|| die "./configure failed"

	emake || make || die
}

pkg_postinst () {
	gnome2_gconf_install
	gst-register-${PV_MAJ_MIN}
}

USE_DESTDIR="1"

DOCS="AUTHORS COPYING INSTALL README RELEASE TODO"

