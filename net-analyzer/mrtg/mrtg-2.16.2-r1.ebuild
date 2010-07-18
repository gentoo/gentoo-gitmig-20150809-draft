# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/mrtg/mrtg-2.16.2-r1.ebuild,v 1.2 2010/07/18 08:23:16 ssuominen Exp $

EAPI="3"

DESCRIPTION="A tool to monitor the traffic load on network-links"
HOMEPAGE="http://oss.oetiker.ch/mrtg/"
SRC_URI="http://oss.oetiker.ch/mrtg/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl
	dev-perl/SNMP_Session
	>=media-libs/gd-1.8.4"

src_prepare() {
	rm ./lib/mrtg2/{SNMP_{Session,util},BER}.pm || die
}

src_install () {
	keepdir /var/lib/mrtg

	emake DESTDIR="${ED}" install || die "emake install failed"
	mv "${ED}/usr/share/doc/"{mrtg2,${PF}}

	newinitd "${FILESDIR}/mrtg.rc" ${PN} || die
	newconfd "${FILESDIR}/mrtg.confd" ${PN} || die
}

pkg_postinst(){
	elog "You must configure mrtg before being able to run it. Try cfgmaker."
	elog "The following thread may be useful:"
	elog "http://forums.gentoo.org/viewtopic-t-105862.html"
}
