# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ninja/ninja-1.5.9_pre9.ebuild,v 1.1 2003/05/12 19:55:30 avenj Exp $

# Get rid of underscore in package name
PV=`echo ${PV} | sed -e 's/_.*//'`

S=${WORKDIR}/${PN}-${PV}
DESCRIPTION="Ninja IRC Client"
HOMEPAGE="http://ninja.qoop.org/"
SRC_URI="http://ninja.qoop.org/ftp/sources/${P/_/}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="ncurses ipv6 ssl"
DEPEND="virtual/glibc
	ncurses? sys-libs/ncurses
	ssl?  dev-libs/openssl"

src_compile() {
	      local myconf
	      use ipv6 && myconf="${myconf} --enable-ipv6"
	      econf ${myconf}
	      emake || die "emake failed"
}

src_install() {
	      einstall
}

