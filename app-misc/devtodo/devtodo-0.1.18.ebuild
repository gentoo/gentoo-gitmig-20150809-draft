# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/devtodo/devtodo-0.1.18.ebuild,v 1.3 2004/11/07 02:49:54 ka0ttic Exp $

inherit eutils gnuconfig bash-completion

DESCRIPTION="A nice command line todo list for developers"
HOMEPAGE="http://swapoff.org/DevTodo"
SRC_URI="http://swapoff.org/files/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~hppa ~amd64 ~ia64 ~s390"
IUSE=""

RDEPEND=">=sys-libs/ncurses-5.2 >=sys-libs/readline-4.1"
DEPEND="${RDEPEND} sys-devel/automake"

src_unpack() {
	unpack ${A}
	cd ${S}

	# bug #55371
	epatch ${FILESDIR}/${PN}-1.1.17-notdl.patch

	gnuconfig_update
}

src_compile() {
	automake
	econf --sysconfdir=/etc/devtodo || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog QuickStart README TODO doc/scripts.sh \
		doc/scripts.tcsh doc/todorc.example contrib/tdrec

	dobashcompletion ${FILESDIR}/${PN}.bash-completion ${PN}
}

pkg_postinst() {
	echo
	einfo "Because of a conflict with app-misc/tdl, the tdl symbolic link"
	einfo "and manual page have been removed."
	einfo "If you upgraded from a previous version, you may have to manually"
	einfo "remove the symbolic links:"
	einfo "  /usr/bin/tdl -> /usr/bin/devtodo"
	einfo "  /usr/share/man/man1/tdl.1.gz -> /usr/share/man/man1/devtodo.1.gz"
	bash-completion_pkg_postinst
}
