# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kmymoney2/kmymoney2-0.8.3-r1.ebuild,v 1.2 2006/04/12 21:58:01 carlo Exp $

inherit kde

DESCRIPTION="Personal Finances Manager for KDE."
HOMEPAGE="http://kmymoney2.sourceforge.net"
SRC_URI="mirror://sourceforge/kmymoney2/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="crypt ofx hbci"

DEPEND="dev-libs/libxml2
	hbci? ( >=net-libs/aqbanking-1.8.0_beta )
	ofx? ( >=dev-libs/libofx-0.7 )"

RDEPEND="${DEPEND}
	crypt? ( app-crypt/gnupg )"

need-kde 3.2

# TODO: support maketest
# (needs cppunit in DEPEND)

pkg_setup() {
	if use hbci && ! built_with_use net-libs/aqbanking kde; then
		eerror "The HBCI plugin is shipped by net-libs/aqbanking,"
		eerror "which has to be built with KDE support."
		die "rebuild net-libs/aqbanking with USE=kde"
	fi
}

src_unpack() {
	# override kde_src_unpack and remove visibility support manually:
	# regenerating the configure script is too error-prone with this
	# package, which uses a lot of custom macros in acinclude.m4.
	unpack ${A}
}

src_compile() {
	export kde_cv_prog_cxx_fvisibility_hidden=no

	local myconf="$(use_enable ofx ofxplugin)
			$(use_enable hbci kbanking)
			--disable-cppunit"

	kde_src_compile
}
