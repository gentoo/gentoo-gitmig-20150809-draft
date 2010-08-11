# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/gobi_loader/gobi_loader-0.7-r1.ebuild,v 1.2 2010/08/11 14:01:18 polynomial-c Exp $

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

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
	sed "s:%LIBDIR%:$(get_libdir):" -i Makefile || die
}

src_install() {
	emake install || die
}

pkg_postinst() {
	udevadm control --reload-rules
	einfo
	einfo "Put your firmware in /lib/firmware/gobi."
	einfo
}
