# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/bnc/bnc-2.6.4.ebuild,v 1.7 2003/09/08 08:35:25 vapier Exp $

MY_P=${P/-/}
DESCRIPTION="BNC (BouNCe) is used as a gateway to an IRC Server"
HOMEPAGE="http://gotbnc.com/"
SRC_URI="http://gotbnc.com/files/${MY_P}.tar.gz
	http://bnc.ircadmin.net/${MY_P}.tar.gz
	ftp://ftp.ircadmin.net/bnc/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND="virtual/glibc"

src_compile() {
	econf
	emake || die
	mv mkpasswd bncmkpasswd
}

src_install() {
	dodoc CHANGES COPYING README
	dobin bnc bncchk bncsetup bncmkpasswd
	insinto /usr/share/${MY_P}
	doins example.conf motd
}

pkg_postinst() {
	einfo "You can find an example motd/conf file here:"
	einfo " /usr/share/${MY_P}/{example.conf,motd}"
}
