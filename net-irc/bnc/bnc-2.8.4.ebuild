# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/bnc/bnc-2.8.4.ebuild,v 1.1 2002/10/23 14:59:26 vapier Exp $

P=${P/-/}
DESCRIPTION="BNC (BouNCe) is used as a gateway to an IRC Server"
HOMEPAGE="http://bnc.ircadmin.net/"
SRC_URI="http://bnc.ircadmin.net/${P}.tar.gz
	ftp://ftp.ircadmin.net/bnc/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~sparc64 ~alpha"
IUSE=""

DEPEND="virtual/glibc"

S="${WORKDIR}/${P}"

src_compile() {
	econf || die
	emake || die
	mv mkpasswd bncmkpasswd
}

src_install() {
	dodoc CHANGES COPYING README
	dobin bnc bncchk bncsetup bncmkpasswd
	insinto /usr/share/${P}
	doins example.conf motd
}

pkg_postinst() {
	einfo "You can find an example motd/conf file here:"
	einfo " /usr/share/${P}/{example.conf,motd}"
}
