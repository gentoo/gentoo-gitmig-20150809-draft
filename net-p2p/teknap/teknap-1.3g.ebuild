# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/teknap/teknap-1.3g.ebuild,v 1.14 2004/06/25 00:36:55 agriffis Exp $

IUSE="xmms gtk ipv6 tcpd"

MY_P=TekNap-${PV}
S=${WORKDIR}/TekNap
DESCRIPTION="TekNap is a console Napster/OpenNap client"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"
HOMEPAGE="http://www.TekNap.com/ http://www.cactuz.org/jnbek/teknap"

SLOT="0"
# please test the current ~testing ebuild, as this does not compile with latest gcc
#KEYWORDS="x86 ppc"
KEYWORDS="-x86 -ppc"
LICENSE="as-is"

DEPEND="virtual/glibc >=sys-libs/ncurses-5.2
	gtk? ( =x11-libs/gtk+-1.2* )
	tcpd? ( sys-apps/tcp-wrappers )
	xmms? ( media-sound/xmms )"

src_compile() {
	local myconf
	use gtk && myconf="--with-gtk"

	use tcpd && myconf="${myconf} --enable-wrap"

	use xmms && myconf="${myconf} --enable-xmms"

	use ipv6 && myconf="${myconf} --enable-ipv6"
	myconf="${myconf} --enable-cdrom"

	econf ${myconf} || die
	make || die

}

src_install () {

	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		datadir=${D}/usr/share/TekNap \
		install || die
	rm ${D}/usr/bin/TekNap
	dosym TekNap-1.3f /usr/bin/TekNap
	dodoc COPYRIGHT README TODO Changelog
	docinto txt
	cd doc
	dodoc *.txt TekNap.faq bugs link-guidelines macosx.notes
	doman TekNap.1
}
