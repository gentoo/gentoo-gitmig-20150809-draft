# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/iksemel/iksemel-1.2.ebuild,v 1.2 2004/09/18 04:33:16 squinky86 Exp $

DESCRIPTION="iksemel is an XML (eXtensible Markup Language) parser library designed for Jabber applications. It is coded in ANSI C for POSIX compatible environments, thus highly portable."
HOMEPAGE="http://iksemel.jabberstudio.org/"

SRC_URI="http://www.jabberstudio.org/files/iksemel/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="gnutls"

DEPEND="virtual/libc
	gnutls? ( net-libs/gnutls )"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
