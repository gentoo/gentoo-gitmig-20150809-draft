# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/oidentd/oidentd-2.0.7-r1.ebuild,v 1.13 2007/04/22 16:49:15 phreak Exp $

DESCRIPTION="Another (RFC1413 compliant) ident daemon"
HOMEPAGE="http://dev.ojnk.net/"
SRC_URI="mirror://sourceforge/ojnk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc alpha arm amd64 ia64 hppa ppc ~mips"
IUSE="ipv6"

DEPEND=""
RDEPEND=""

src_compile() {
	econf $( use_enable ipv6 ) || die "econf failed!"
	emake || die "emake failed!"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed!"

	dodoc AUTHORS ChangeLog README TODO NEWS \
		"${FILESDIR}"/${PN}_masq.conf "${FILESDIR}"/${PN}.conf

	newinitd "${FILESDIR}"/oidentd-${PV}-init ${PN}
	newconfd "${FILESDIR}"/oidentd-${PV}-confd ${PN}
}

pkg_postinst() {
	echo
	elog "Example configuration files are in /usr/share/doc/${PF}"
	echo
}
