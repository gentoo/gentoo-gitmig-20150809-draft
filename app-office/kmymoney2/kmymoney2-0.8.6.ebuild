# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kmymoney2/kmymoney2-0.8.6.ebuild,v 1.1 2007/03/25 21:19:43 tsunam Exp $

inherit kde

DESCRIPTION="Personal Finances Manager for KDE."
HOMEPAGE="http://kmymoney2.sourceforge.net"
SRC_URI="mirror://sourceforge/kmymoney2/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="crypt ofx hbci"

DEPEND="dev-libs/libxml2
	hbci? ( >=net-libs/aqbanking-1.8.0_beta )
	ofx? ( >=dev-libs/libofx-0.7 )"

RDEPEND="${DEPEND}
	crypt? ( app-crypt/gnupg )"

DEPEND="${DEPEND}
	dev-util/cppunit"

need-kde 3.4

# TODO: support maketest
# (needs cppunit in DEPEND)

pkg_setup() {
	if use hbci && ! built_with_use net-libs/aqbanking kde; then
		eerror "The HBCI plugin is shipped by net-libs/aqbanking,"
		eerror "which has to be built with KDE support."
		die "rebuild net-libs/aqbanking with USE=kde"
	fi
}

src_compile() {
	local myconf="$(use_enable ofx ofxplugin)
			$(use_enable hbci kbanking)
			--disable-cppunit"

	# bug 132665
	replace-flags "-Os" "-O2"

	kde_src_compile
}
