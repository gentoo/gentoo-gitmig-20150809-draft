# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/DirectFB-extra/DirectFB-extra-0.9.16.ebuild,v 1.2 2003/06/13 12:58:40 seemant Exp $

IUSE="quicktime flash imlib avi"

S=${WORKDIR}/${P}
DESCRIPTION="Extra image/video/font providers and graphics/input drivers for DirectFB"
HOMEPAGE="http://www.directfb.org/"
SRC_URI="http://directfb.org/download/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND=">=dev-libs/DirectFB-${PV}*
	quicktime? ( media-libs/openquicktime )
	flash? ( media-libs/libflash )
	imlib? ( media-libs/imlib2 )"
#	avi? ( media-video/avifile )"


src_compile() {

	local myconf

	use flash \
		&& myconf="${myconf} --enable-flash" \
		|| myconf="${myconf} --disable-flash"

#	use avi \
#		&& myconf="${myconf} --enable-avifile" \
#		|| myconf="${myconf} --disable-avifile"

	myconf="${myconf} --disable-avifile"

	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
