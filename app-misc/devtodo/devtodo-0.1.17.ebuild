# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/devtodo/devtodo-0.1.17.ebuild,v 1.7 2003/12/29 01:13:03 avenj Exp $

inherit gnuconfig

IUSE=""
DESCRIPTION="A nice command line todo list for developers"
HOMEPAGE="http://devtodo.sourceforge.net/"
SRC_URI="http://devtodo.sourceforge.net/${PV}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc ~alpha ~hppa ~mips ~arm amd64 ~ia64"

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

	econf  \
		--sysconfdir=/etc/devtodo || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog QuickStart README TODO
	dodoc doc/scripts.sh doc/scripts.tcsh doc/todorc.example contrib/tdrec
}
