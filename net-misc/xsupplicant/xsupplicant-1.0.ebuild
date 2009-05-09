# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/xsupplicant/xsupplicant-1.0.ebuild,v 1.3 2009/05/09 16:48:55 volkmar Exp $

S="${WORKDIR}/${PN}"

DESCRIPTION="Open Source Implementation of IEEE 802.1x"

HOMEPAGE="http://open1x.sourceforge.net"
SRC_URI="mirror://sourceforge/open1x/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND=">=dev-libs/openssl-0.9.7
		sys-apps/pcsc-lite"
RDEPEND="${DEPEND}"

src_compile() {
	econf --enable-eap-sim || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS README README.wireless_cards \
		doc/README.certificates doc/Open1x-UserGuide.pdf

	docinto examples
	dodoc etc/*-example.conf

	insinto /etc
	newins etc/xsupplicant.conf xsupplicant.conf.example

	newinitd "${FILESDIR}"/xsupplicant.init.d xsupplicant

	newconfd "${FILESDIR}"/xsupplicant.conf.d xsupplicant
}

pkg_postinst() {
	einfo
	einfo "To use ${P} you must create the configuration file"
	einfo "/etc/xsupplicant.conf"
	einfo
	einfo "An example configuration file has been installed as"
	einfo "/etc/xsupplicant.conf.example"
	einfo
}
