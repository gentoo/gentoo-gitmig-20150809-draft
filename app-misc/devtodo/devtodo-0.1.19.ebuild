# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/devtodo/devtodo-0.1.19.ebuild,v 1.8 2005/08/03 20:03:36 kloeri Exp $

inherit eutils gnuconfig bash-completion flag-o-matic

DESCRIPTION="A nice command line todo list for developers"
HOMEPAGE="http://swapoff.org/DevTodo"
SRC_URI="http://swapoff.org/files/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE=""

RDEPEND=">=sys-libs/ncurses-5.2
	>=sys-libs/readline-4.1"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-0.1.18-gcc4.diff
	epatch ${FILESDIR}/${P}-gentoo.diff
	gnuconfig_update
}

src_compile() {
	einfo "Running autoreconf"
	autoreconf -f -i || die "autoreconf failed"
	replace-flags -O[23] -O1
	econf --sysconfdir=/etc/devtodo || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog QuickStart README doc/scripts.sh \
	doc/scripts.tcsh doc/todorc.example || die "dodoc failed"

	dobashcompletion contrib/${PN}.bash-completion ${PN}
	rm contrib/${PN}.bash-completion
	docinto contrib
	dodoc contrib/*
}

pkg_postinst() {
	echo
	einfo "Because of a conflict with app-misc/tdl, the tdl symbolic link"
	einfo "and manual page have been removed."
	bash-completion_pkg_postinst
}
