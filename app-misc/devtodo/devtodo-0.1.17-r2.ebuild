# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/devtodo/devtodo-0.1.17-r2.ebuild,v 1.9 2004/11/18 16:09:06 ka0ttic Exp $

inherit eutils gnuconfig flag-o-matic

DESCRIPTION="A nice command line todo list for developers"
HOMEPAGE="http://swapoff.org/DevTodo"
SRC_URI="http://swapoff.org/files/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha ~hppa amd64 ~ia64 ~s390 ppc64"
IUSE=""

RDEPEND=">=sys-libs/ncurses-5.2
	>=sys-libs/readline-4.1"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}.patch # gcc-3.3 fix
	epatch ${FILESDIR}/${PN}-fix-cd-builtin.patch   # bug 60206
	epatch ${FILESDIR}/${PN}-fix-TERM-sigabrt.patch # bug 60207
	epatch ${FILESDIR}/${PN}-0.1.18-gentoo.diff
	gnuconfig_update
}

src_compile() {
	einfo "Running autoreconf"
	WANT_AUTOCONF="2.5" autoreconf -f -i || die "autoreconf failed"
	replace-flags -O? -O1
	econf --sysconfdir=/etc/devtodo || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog QuickStart README TODO doc/scripts.sh \
	doc/scripts.tcsh doc/todorc.example contrib/tdrec || die "dodoc failed"
}

pkg_postinst() {
	einfo "Because of a conflict with app-misc/tdl, the tdl symbolic link"
	einfo "and manual page have been removed."
	einfo "If you upgraded from a previous version, you may have to manually"
	einfo "remove the symbolic links:"
	einfo "  /usr/bin/tdl -> /usr/bin/devtodo"
	einfo "  /usr/share/man/man1/tdl.1.gz -> /usr/share/man/man1/devtodo.1.gz"
}
