# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/asmail/asmail-0.56.ebuild,v 1.1 2004/09/03 09:19:26 ticho Exp $

DESCRIPTION="Afterstep mail-checker like xbiff"
HOMEPAGE="http://asmail.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="X jpeg"

DEPEND="virtual/glibc
	X? ( virtual/x11 )
	jpeg? ( media-libs/jpeg )"

src_compile() {
	econf \
		`use_with X` \
		`use_enable jpeg`
	emake
}

src_install() {
	dodir /usr/X11R6/bin
	dodir /usr/share/man/man1
	make \
		AFTER_BIN_DIR=${D}/usr/X11R6/bin \
		install || die
	make \
		AFTER_MAN_DIR=${D}/usr/share/man/man1 \
		install.man || die

	dodoc README README.8bpp INSTALL sample.asmailrc
}
