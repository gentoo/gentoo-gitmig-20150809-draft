# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/gperiodic/gperiodic-1.3.2.ebuild,v 1.12 2004/04/21 16:25:20 kugelfang Exp $

inherit eutils

DESCRIPTION="periodic table application for Linux"
SRC_URI="ftp://ftp.seul.org/pub/gperiodic/${P}.tar.gz"
HOMEPAGE="http://gperiodic.seul.org/"

KEYWORDS="x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE="nls"

DEPEND=">=sys-libs/ncurses-5.2
	=x11-libs/gtk+-1.2*
	nls? ( sys-devel/gettext )"

PROVIDE="app-misc/gperiodic"

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
