# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/yahoo-transport/yahoo-transport-2.3.1-r1.ebuild,v 1.5 2005/04/02 18:05:38 weeve Exp $

inherit eutils

DESCRIPTION="Open Source Jabber Server Yahoo transport"
HOMEPAGE="http://yahoo-transport-2.jabberstudio.org/"
SRC_URI="http://www.jabberstudio.org/files/yahoo-transport-2/${P}.tar.gz
	http://www.lucas-nussbaum.net/yahoo-transport+authfix.diff"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc hppa sparc"
SLOT="0"
IUSE=""
DEPEND="=net-im/jabberd-1.4*"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	epatch ${FILESDIR}/yahoo-makefile.patch
	#Again a patch to the auth scheme
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
	einfo
	einfo "Please read /usr/share/doc/${P}/README.Gentoo.gz"
	einfo "And please notice that now yahoo-transport comes with a init.d script"
	einfo "dont forget to add it to your runlevel."
	einfo
}
