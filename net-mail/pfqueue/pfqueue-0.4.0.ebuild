# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/pfqueue/pfqueue-0.4.0.ebuild,v 1.1 2005/06/09 19:14:41 ticho Exp $

inherit eutils toolchain-funcs

DESCRIPTION="pfqueue is an ncurses console-based tool for managing Postfix
queued messages"
HOMEPAGE="http://pfqueue.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="virtual/libc
		sys-devel/libtool"
RDEPEND="mail-mta/postfix"

pkg_setup() {
	if [ $(gcc-major-version) = 4 ] ; then
		ewarn "pfqueue-0.4.0 does not work with gcc-4.x, sorry. pfqueue-0.4.1 will."
		die "pfqueue-0.4.0 does not work with gcc4"
	fi
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README ChangeLog COPYING NEWS TODO AUTHORS
}
