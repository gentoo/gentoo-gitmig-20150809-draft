# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/darkstat/darkstat-2.5.ebuild,v 1.2 2004/01/03 02:18:56 zul Exp $

DESCRIPTION="darkstat is a network traffic analyzer"
HOMEPAGE="http://members.optushome.com.au/emikulic/net/darkstat/"
SRC_URI="http://members.optushome.com.au/emikulic/net/darkstat/${P}.tar.gz"

KEYWORDS="x86"
IUSE=""
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=net-libs/libpcap-0.7.1"
RDEPEND=""

S="${WORKDIR}/${P}"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}
src_install() {
	make DESTDIR=${D} install || die
	dodir /var/spool/darkstat

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL ISSUES NEWS README TODO

	exeinto /etc/init.d ; newexe ${FILESDIR}/darkstat-init darkstat
	insinto /etc/conf.d ; newins ${FILESDIR}/darkstat-confd darkstat
}

