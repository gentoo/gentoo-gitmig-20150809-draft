# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/scrollz/scrollz-1.8m.ebuild,v 1.2 2003/02/13 14:16:48 vapier Exp $

IUSE="ipv6 socks5"

MY_PN=${PN/scrollz/ScrollZ}	
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Advanced IRC client based on ircII"
SRC_URI="http://scrollz.broken.com/source/${MY_P}.tar.bz2"
HOMEPAGE="http://www.scrollz.com"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/glibc"

src_compile() {

	myconf=""
	use ipv6 && myconf="${myconf} --enable-ipv6"
	use socks5 && myconf="${myconf} --enable-socks5"

	econf ${myconf} --with-default-server=localhost 
	emake
}

src_install() {

	preplib /usr

        exeinto usr/bin
	newexe source/scrollz ${P}
	dosym ${P} /usr/bin/ScrollZ
	dosym ${P} /usr/bin/scrollz

	doman scrollz.1

	insinto usr/share/irc
	doins ScrollZ.help
	doins ScrollZ.addon

	dodoc doc/ScrollZ.doc README.ScrollZ

}
