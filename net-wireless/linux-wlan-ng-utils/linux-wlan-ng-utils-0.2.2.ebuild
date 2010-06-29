# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/linux-wlan-ng-utils/linux-wlan-ng-utils-0.2.2.ebuild,v 1.7 2010/06/29 15:29:45 ssuominen Exp $

inherit eutils toolchain-funcs

MY_P=${P/-utils/}

DESCRIPTION="Key generators from the linux-wlan-ng project."
HOMEPAGE="http://linux-wlan.org"
SRC_URI="ftp://ftp.linux-wlan.org/pub/linux-wlan-ng/${MY_P}.tar.bz2"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-libs/openssl
	!<net-wireless/linux-wlan-ng-0.2.2"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

KEYGENS="keygen lwepgen"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-asneeded.patch
}

src_compile() {
	tc-export CC

	for keygen in ${KEYGENS}; do
		cd add-ons/${keygen}
		emake ${keygen} || die
		cd "${S}"
	done
}

src_install() {
	for keygen in ${KEYGENS}; do
		cd add-ons/${keygen}
		dosbin ${keygen} || die
		cd "${S}"
	done
}
