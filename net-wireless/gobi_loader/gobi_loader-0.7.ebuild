# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/gobi_loader/gobi_loader-0.7.ebuild,v 1.1 2010/06/27 12:49:12 polynomial-c Exp $

EAPI="2"
inherit eutils

DESCRIPTION="gobi_loader is a firmware loader for Qualcomm Gobi USB chipsets"
HOMEPAGE="http://www.codon.org.uk/~mjg59/gobi_loader/"
SRC_URI="http://www.codon.org.uk/~mjg59/${PN}/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="virtual/libusb:0"
RDEPEND="${DEPEND}"

src_install() {
	emake || die

	# Makefile is bad
	dosbin gobi_loader
	insinto /etc/udev/rules.d
	doins 60-gobi.rules
}

pkg_postinst() {
	einfo
	einfo "Put your firmware in /lib/firmware/gobi."
	einfo
}
