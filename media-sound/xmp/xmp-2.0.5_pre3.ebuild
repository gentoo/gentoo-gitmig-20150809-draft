# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmp/xmp-2.0.5_pre3.ebuild,v 1.1 2002/06/17 13:56:30 karltk Exp $

S="${WORKDIR}/${PN}-2.0.5-pre3"
DESCRIPTION="Extended Module Player"
SRC_URI="http://telia.dl.sourceforge.net/sourceforge/xmp/${PN}-2.0.5pre3.tar.bz2"
HOMEPAGE="http://xmp.sf.net"
LICENSE="GPL-2"
DEPEND="virtual/glibc
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	xmms? ( media-sound/xmms )
	esd? ( media-sound/esound )
	nas? ( media-libs/nas )
	X? ( virtual/x11 )
	"

src_compile() {
	local myc

	use alsa && myc="${myc} --enable-alsa" || myc="${myc} --disable-alsa"
	use arts && myc="${myc} --enable-arts" || myc="${myc} --disable-arts"
	use esd && myc="${myc} --enable-esd" || myc="${myc} --disable-esd"
	use nas && myc="${myc} --enable-nas" || myc="${myc} --disable-nas"
	use oss && myc="${myc} --enable-oss" || myc="${myc} --disable-oss"
	use xmms && myc="${myc} --enable-xmms" || myc="${myc} --disable-xmms"
	use X && myc="${myc} --with-x" || myc="${myc} --with-x"

	econf ${myc} || die
		
	make || die 
}

src_install () {
	make DEST_DIR=${D} MAN_DIR=${D}/usr/share/man/man1 install || die
	dodoc INSTALL README
}
