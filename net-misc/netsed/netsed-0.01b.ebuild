# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netsed/netsed-0.01b.ebuild,v 1.2 2004/05/28 15:41:04 vapier Exp $

inherit eutils

DESCRIPTION="A small and handful utility designed to alter the contents of packets forwarded thru your network in real time"
HOMEPAGE="http://freshmeat.net/projects/netsed"
SRC_URI="http://dione.ids.pl/~lcamtuf/${PN}.tgz
	http://http.us.debian.org/debian/pool/main/n/netsed/${PN}_0.01c-2.diff.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/glibc"

src_unpack() {
	mkdir -p ${S}
	cd ${S}
	unpack ${A}
	epatch ${PN}_0.01c-2.diff
}

src_compile() {
	make CFLAGS="${CFLAGS}"
}

src_install() {
	dobin netsed
	doman debian/netsed.1
	dodoc README
}
