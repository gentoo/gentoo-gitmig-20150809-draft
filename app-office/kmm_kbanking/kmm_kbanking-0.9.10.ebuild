# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kmm_kbanking/kmm_kbanking-0.9.10.ebuild,v 1.2 2009/07/06 09:52:14 hanno Exp $

EAPI="2"
ARTS_REQUIRED="never"
inherit kde

DESCRIPTION="KMyMoney2 HBCI plugin utilizing AqBanking."
HOMEPAGE="http://www.aquamaniac.de/sites/download/packages.php?package=05&showall=1"
SRC_URI="http://www2.aquamaniac.de/sites/download/download.php?package=05&release=08&file=01&dummy=${P}.tar.bz2 -> ${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=app-office/kmymoney2-0.9.2
	|| (
		>=net-libs/aqbanking-3.8.1[hbci,kde,qt3]
		>=net-libs/aqbanking-4.0.0[qt3,kde]
	)
	>=sys-libs/gwenhywfar-3.5.2"
RDEPEND="${DEPEND}"

need-kde 3.5

src_configure() {
	local myconf
	myconf="${myconf} \
		--enable-aqbanking \
		--enable-gwenhywfar \
		--without-arts"

	kde_src_configure
}
