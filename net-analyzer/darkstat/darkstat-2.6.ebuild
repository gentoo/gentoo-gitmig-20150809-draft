# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/darkstat/darkstat-2.6.ebuild,v 1.1 2004/01/03 02:47:26 zul Exp $

DESCRIPTION="darkstat is a network traffic analyzer"
HOMEPAGE="http://dmr.ath.cx/net/darkstat/"
SRC_URI="http://dmr.ath.cx/net/darkstat/${P}.tar.gz"

KEYWORDS="~x86"
IUSE="nls"
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=net-libs/libpcap-0.7.1
		nls? ( sys-devel/gettext ) "
RDEPEND=""

S="${WORKDIR}/${P}"

src_compile() {
	use nls && myconf="`use_with nls`"
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} || die "./configure failed"
	emake || die
}
src_install() {
	make DESTDIR=${D} install || die

	dodir /var/spool/darkstat

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL ISSUES NEWS README TODO

	exeinto /etc/init.d ; newexe ${FILESDIR}/darkstat-init darkstat
	insinto /etc/conf.d ; newins ${FILESDIR}/darkstat-confd darkstat
}

