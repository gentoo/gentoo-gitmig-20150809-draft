# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/msn-transport/msn-transport-20040228.ebuild,v 1.1 2004/04/08 02:01:48 humpback Exp $

MY_PV="1.2.8rc-cvs"
S="${WORKDIR}/${PN}-${MY_PV}"
DESCRIPTION="Open Source Jabber Server MSN transport"
HOMEPAGE="http://msn-transport.jabberstudio.org/"
SRC_URI="http://msn-transport.jabberstudio.org/${PN}-cvs.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""
SLOT="0"

DEPEND=">=net-im/jabberd-1.4.3-r3
		net-misc/curl"

src_compile() {
		econf \
				--with-jabberd=/usr/include/jabberd \
				--with-pth=/usr/include \
				|| die
		emake || die
}

src_install() {
		dodir /etc/jabber /usr/lib/jabberd
		insinto /usr/lib/jabberd
		doins src/msntrans.so
		insinto /etc/jabber
		doins  ${FILESDIR}/msnt.xml
		exeinto /etc/init.d
		newexe ${FILESDIR}/msn-transport.init msn-transport
		dodoc README ${FILESDIR}/README.Gentoo msnt.xml
}

pkg_postinst() {
	einfo
	einfo "Please read /usr/share/doc/${P}/README.Gentoo.gz"
	einfo "And please notice that now msn-transport comes with a init.d script"
	einfo "dont forget to add it to your runlevel."
	einfo
}
