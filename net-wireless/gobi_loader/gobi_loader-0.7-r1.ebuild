# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/gobi_loader/gobi_loader-0.7-r1.ebuild,v 1.1 2010/08/03 18:44:52 polynomial-c Exp $

EAPI="2"
inherit eutils multilib

DESCRIPTION="gobi_loader is a firmware loader for Qualcomm Gobi USB chipsets"
HOMEPAGE="http://www.codon.org.uk/~mjg59/gobi_loader/"
SRC_URI="http://www.codon.org.uk/~mjg59/${PN}/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/libusb:0"
RDEPEND="${DEPEND}"

src_install() {
	# Makefile is bad
	insinto /$(get_libdir)/udev
	insopts -m0755
	doins gobi_loader

	insinto /etc/udev/rules.d
	insopts -m0644
	doins 60-gobi.rules
}

pkg_postinst() {
	einfo
	einfo "Put your firmware in /lib/firmware/gobi."
	einfo
}
