# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/open-cobol/open-cobol-0.30.ebuild,v 1.1 2005/01/03 07:08:21 matsuu Exp $

DESCRIPTION="an open-source COBOL compiler"
HOMEPAGE="http://www.open-cobol.org/"
SRC_URI="mirror://sourceforge/open-cobol/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="nls berkdb readline ncurses"

DEPEND="sys-devel/libtool
	>=dev-libs/gmp-3.1.1
	berkdb? ( =sys-libs/db-1* )
	readline? ( sys-libs/readline )
	ncurses? ( >=sys-libs/ncurses-5.2 )"

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
