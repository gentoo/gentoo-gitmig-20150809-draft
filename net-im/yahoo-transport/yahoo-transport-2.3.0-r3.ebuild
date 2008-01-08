# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/yahoo-transport/yahoo-transport-2.3.0-r3.ebuild,v 1.5 2008/01/08 08:32:55 nelchael Exp $

inherit eutils

DESCRIPTION="Open Source Jabber Server Yahoo transport"
HOMEPAGE="http://yahoo-transport-2.jabberstudio.org/"
SRC_URI="http://www.jabberstudio.org/files/yahoo-transport-2/${P}.tar.gz
	http://dev.gentoo.org/~humpback/yahoo-transport+newauth.diff
	http://www.lucas-nussbaum.net/yahoo-transport+authfix.diff"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
SLOT="0"
IUSE=""
DEPEND="net-im/jabberd"

src_unpack() {
		unpack ${P}.tar.gz
		cd ${S}
		epatch ${FILESDIR}/yahoo-makefile.patch
		#This applies a patch to the auth scheme
		#http://mailman.jabber.org/pipermail/jadmin/2004-January/013922.html
		epatch ${DISTDIR}/yahoo-transport+newauth.diff
		#Second auth patch for 2.3.0
		epatch ${DISTDIR}/yahoo-transport+authfix.diff
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
		 exeinto /etc/init.d
		 newexe ${FILESDIR}/yahoo-transport.init yahoo-transport
		 dodoc README ${FILESDIR}/README.Gentoo
}

pkg_postinst() {
	elog
	elog "Please read /usr/share/doc/${P}/README.Gentoo.gz"
	elog "And please notice that now msn-transport comes with a init.d script"
	elog "dont forget to add it to your runlevel."
	elog
	elog "IMPORTANT"
	elog "This version uses a patch that was designed for version 2.3.1"
	elog "please consider using the updated version"
	elog
}
