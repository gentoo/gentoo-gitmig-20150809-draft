# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ngircd/ngircd-0.7.7.ebuild,v 1.1 2004/04/19 21:43:27 zul Exp $

DESCRIPTION="A IRC server written from scratch."
HOMEPAGE="http://arthur.ath.cx/~alex/ngircd/"
SRC_URI="ftp://download.berlios.de/pub/ngircd/${P}.tar.gz
ftp://arthur.ath.cx/pub/Users/alex/ngircd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND="virtual/glibc"
RDEPEND=""

src_compile() {
	econf
	make
}

src_install() {
	make DESTDIR="${D}" install
}
