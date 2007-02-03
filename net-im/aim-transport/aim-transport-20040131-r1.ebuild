# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/aim-transport/aim-transport-20040131-r1.ebuild,v 1.13 2007/02/03 16:49:08 gmsoft Exp $

inherit eutils

MY_PN="${PN}-stable"
S="${WORKDIR}/${MY_PN}-${PV}"
DESCRIPTION="AOL Instant Messaging transport for jabberd"

HOMEPAGE="http://aim-transport.jabberstudio.org/"

SRC_URI="http://aim-transport.jabberstudio.org/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="x86 ~sparc ~ppc"

IUSE=""

DEPEND="=net-im/jabberd-1.4*"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/aimtrans.patch
}

src_compile() {
	einfo
	einfo "Please ignore any errors/warnings"
	einfo
	automake
	libtoolize --force
	aclocal
	autoconf
	./configure --with-jabberd=/usr/include/jabberd || die "./configure failed"
	emake || die
}

src_install() {
	dodir /etc/jabber /usr/lib/jabberd
	insinto /usr/lib/jabberd
	doins src/aimtrans.so
	insinto /etc/jabber
	doins ${FILESDIR}/aimtrans.xml
	exeinto /etc/init.d
	newexe ${FILESDIR}/aim-transport.init aim-transport
	dodoc README ${FILESDIR}/README.Gentoo TODO aim.xml
}

pkg_postinst() {
	einfo
	einfo "Please read /usr/share/doc/${PF}/README.Gentoo.gz"
	einfo "And please notice that now aim-transport comes with a init.d script"
	einfo "dont forget to add it to your runlevel."
	einfo
}
