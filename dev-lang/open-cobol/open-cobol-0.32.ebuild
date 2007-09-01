# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/open-cobol/open-cobol-0.32.ebuild,v 1.1 2007/09/01 19:56:03 opfer Exp $

DESCRIPTION="an open-source COBOL compiler"
HOMEPAGE="http://www.open-cobol.org/"
SRC_URI="mirror://sourceforge/open-cobol/${P}.tar.gz"
inherit eutils

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="nls berkdb readline ncurses"

DEPEND="sys-devel/libtool
	>=dev-libs/gmp-3.1.1
	berkdb? ( =sys-libs/db-1* )
	readline? ( sys-libs/readline )
	ncurses? ( >=sys-libs/ncurses-5.2 )"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-gmp-configure.patch"
}

src_compile() {

	# --with-db does not work
	econf \
		$(use_with berkdb db1) \
		$(use_enable nls) \
		$(use_with readline) || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ABOUT-NLS AUTHORS ChangeLog INSTALL NEWS README
}
