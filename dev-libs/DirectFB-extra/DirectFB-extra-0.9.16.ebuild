# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/DirectFB-extra/DirectFB-extra-0.9.16.ebuild,v 1.7 2004/01/26 08:27:09 vapier Exp $

inherit eutils

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

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-newdirectfb.patch
}

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
