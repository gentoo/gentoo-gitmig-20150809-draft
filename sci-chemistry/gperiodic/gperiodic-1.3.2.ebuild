# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/gperiodic/gperiodic-1.3.2.ebuild,v 1.2 2005/02/04 23:48:57 cryos Exp $

inherit eutils

DESCRIPTION="periodic table application for Linux"
SRC_URI="ftp://ftp.seul.org/pub/gperiodic/${P}.tar.gz"
HOMEPAGE="http://gperiodic.seul.org/"

KEYWORDS="x86 amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE="nls"

DEPEND=">=sys-libs/ncurses-5.2
	=x11-libs/gtk+-1.2*
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	einstall || die
	doman man/gperiodic.1
	dodoc ABOUT-NLS AUTHORS ChangeLog NEWS README
}
