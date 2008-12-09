# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kmymoney2/kmymoney2-0.8.8.ebuild,v 1.7 2008/12/09 18:38:03 tgurr Exp $

inherit kde

DESCRIPTION="Personal Finances Manager for KDE."
HOMEPAGE="http://kmymoney2.sourceforge.net"
SRC_URI="mirror://sourceforge/kmymoney2/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 sparc x86"
IUSE="crypt ofx hbci"

DEPEND="dev-libs/libxml2
	hbci? ( >=net-libs/aqbanking-1.8.0_beta )
	ofx? ( >=dev-libs/libofx-0.7 )"

RDEPEND="${DEPEND}
	crypt? ( app-crypt/gnupg )"

#DEPEND="${DEPEND}
#	dev-util/cppunit"

need-kde 3.5

# TODO: support maketest
# (needs cppunit in DEPEND)

PATCHES=( "${FILESDIR}/kmymoney2.desktop.diff" )

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

src_install() {
	kde_src_install
	# bug 139082
	rm "${D}"/usr/bin/kmymoney
}
