# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/devtodo/devtodo-0.1.17.ebuild,v 1.14 2004/06/28 03:31:19 vapier Exp $

inherit eutils gnuconfig

DESCRIPTION="A nice command line todo list for developers"
HOMEPAGE="http://devtodo.sourceforge.net/"
SRC_URI="http://devtodo.sourceforge.net/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha ~hppa amd64 ~ia64 s390"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.2
	>=sys-libs/readline-4.1"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Patch to allow compilation with gcc-3.3
	epatch ${FILESDIR}/${PN}.patch
}

src_compile() {
	gnuconfig_update
	econf --sysconfdir=/etc/devtodo || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog QuickStart README TODO
	dodoc doc/scripts.sh doc/scripts.tcsh doc/todorc.example contrib/tdrec
}
