# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/iksemel/iksemel-1.2.ebuild,v 1.5 2007/02/16 17:22:20 truedfx Exp $

DESCRIPTION="iksemel is an XML (eXtensible Markup Language) parser library designed for Jabber applications. It is coded in ANSI C for POSIX compatible environments, thus highly portable."
HOMEPAGE="http://iksemel.jabberstudio.org/"

SRC_URI="http://www.jabberstudio.org/files/iksemel/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="gnutls"

DEPEND="virtual/libc
	gnutls? ( net-libs/gnutls )"

src_test() {
	# make test is b0rken
	einfo "Skipping make test"
}

src_install() {
	make DESTDIR=${D} install || die
}
