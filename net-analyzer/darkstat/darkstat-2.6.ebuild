# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/darkstat/darkstat-2.6.ebuild,v 1.5 2005/01/29 05:12:50 dragonheart Exp $

DESCRIPTION="darkstat is a network traffic analyzer"
HOMEPAGE="http://dmr.ath.cx/net/darkstat/"
SRC_URI="http://dmr.ath.cx/net/darkstat/${P}.tar.gz"

KEYWORDS="x86 ~ppc"
IUSE="nls"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/libpcap
		nls? ( sys-devel/gettext ) "
RDEPEND=""

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

