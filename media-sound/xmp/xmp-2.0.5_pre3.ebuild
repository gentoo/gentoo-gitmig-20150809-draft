# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmp/xmp-2.0.5_pre3.ebuild,v 1.3 2002/09/11 15:23:56 karltk Exp $

S="${WORKDIR}/${PN}-2.0.5-pre3"
DESCRIPTION="Extended Module Player"
SRC_URI="mirror://sourceforge/xmp/${PN}-2.0.5pre3.tar.bz2"
HOMEPAGE="http://xmp.sf.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="X? ( virtual/x11 )
	esd? ( media-sound/esound )
	nas? ( media-libs/nas )
	alsa? ( =media-libs/alsa-lib-0.5* )
	arts? ( kde-base/arts )
	xmms? ( media-sound/xmms )"

src_compile() {
	local myconf

	use alsa \
		&& myconf="${myconf} --enable-alsa" \
		|| myconf="${myconf} --disable-alsa"

	use arts \
		&& myconf="${myconf} --enable-arts" \
		|| myconf="${myconf} --disable-arts"

	use esd \
		&& myconf="${myconf} --enable-esd" \
		|| myconf="${myconf} --disable-esd"

	use nas \
		&& myconf="${myconf} --enable-nas" \
		|| myconf="${myconf} --disable-nas"

	use oss \
		&& myconf="${myconf} --enable-oss" \
		|| myconf="${myconf} --disable-oss"

	use xmms \
		&& myconf="${myconf} --enable-xmms" \
		|| myconf="${myconf} --disable-xmms"

	use X \
		&& myconf="${myconf} --with-x" \
		|| myconf="${myconf} --with-x"

	econf ${myconf} || die
		
	make || die 
}

src_install () {
	make DEST_DIR=${D} MAN_DIR=${D}/usr/share/man/man1 install || die
	dodoc INSTALL README
}
