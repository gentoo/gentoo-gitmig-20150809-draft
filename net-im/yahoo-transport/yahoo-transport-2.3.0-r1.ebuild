# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/yahoo-transport/yahoo-transport-2.3.0-r1.ebuild,v 1.1 2004/01/23 19:33:17 humpback Exp $

DESCRIPTION="Open Source Jabber Server Yahoo transport"
HOMEPAGE="http://yahoo-transport-2.jabberstudio.org/"
SRC_URI="http://www.jabberstudio.org/files/yahoo-transport-2/${P}.tar.gz
	http://dev.gentoo.org/~humpback/yahoo-transport+newauth.diff"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

DEPEND=">=net-im/jabberd-1.4.3"

src_unpack() {
		unpack ${P}.tar.gz
		cd ${S}
		epatch ${FILESDIR}/yahoo-makefile.patch
		#This applies a patch to the auth scheme
		#http://mailman.jabber.org/pipermail/jadmin/2004-January/013922.html
		epatch ${DISTDIR}/yahoo-transport+newauth.diff
}

src_compile() {
		  emake || die
}

src_install() {
		 dodir /etc/jabber /usr/lib/jabberd
		 insinto /usr/lib/jabberd
		 doins yahoo-transport.so
		 insinto /etc/jabber
		 doins  ${FILESDIR}/yahootrans.xml
		 dodoc README ${FILESDIR}/README.Gentoo
}

pkg_postinst() {
	einfo
	einfo "Please read /usr/share/doc/${P}/README.Gentoo.gz"
	einfo
}
