# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/DirectFB-extra/DirectFB-extra-0.9.16.ebuild,v 1.6 2004/01/02 17:32:02 bazik Exp $


DESCRIPTION="Extra image/video/font providers and graphics/input drivers for DirectFB"
HOMEPAGE="http://www.directfb.org/"
SRC_URI="http://directfb.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc -sparc"
IUSE="quicktime flash imlib avi"

DEPEND=">=dev-libs/DirectFB-${PV}*
	quicktime? ( media-libs/openquicktime )
	flash? ( media-libs/libflash )
	imlib? ( media-libs/imlib2 )"
#	avi? ( media-video/avifile )"

src_compile() {
#		`use_enable avi avifile` \
	econf \
		`use_enable flash` \
		--disable-avifile \
		 || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
