# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/devtodo/devtodo-0.1.18-r1.ebuild,v 1.2 2004/11/14 02:40:11 ka0ttic Exp $

inherit eutils gnuconfig bash-completion flag-o-matic

DESCRIPTION="A nice command line todo list for developers"
HOMEPAGE="http://swapoff.org/DevTodo"
SRC_URI="http://swapoff.org/files/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~mips ~alpha ~hppa ~amd64 ~ia64 s390"
IUSE=""

RDEPEND=">=sys-libs/ncurses-5.2 >=sys-libs/readline-4.1"
DEPEND="${RDEPEND} sys-devel/automake"

src_unpack() {
	unpack ${A}
	cd ${S}

	# bug #55371 - tdl conflicts with app-misc/tdl
	epatch ${FILESDIR}/${PN}-1.1.17-notdl.patch
	# invalid pointer bug that rears its head w/gcc-3.4.x
	epatch ${FILESDIR}/${P}-invalid-ptr.patch
	gnuconfig_update
}

src_compile() {
	autoreconf || die "autoreconf failed"
	replace-flags -O? -O1
	econf --sysconfdir=/etc/devtodo || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog QuickStart README TODO doc/scripts.sh \
		doc/scripts.tcsh doc/todorc.example contrib/tdrec
	dobashcompletion ${FILESDIR}/${PN}.bash-completion ${PN}
}

pkg_postinst() {
	echo
	einfo "Because of a conflict with app-misc/tdl, the tdl symbolic link"
	einfo "and manual page have been removed."
	bash-completion_pkg_postinst
}
