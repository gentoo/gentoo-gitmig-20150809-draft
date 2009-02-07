# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/gatt/gatt-0.6.3.ebuild,v 1.4 2009/02/07 16:00:52 fauli Exp $

inherit eutils

DESCRIPTION="Gentoo Arch Testing Tool for architecture tester and developer"
HOMEPAGE="http://gatt.sourceforge.net/
	http://www.gentoo.org/proj/en/base/x86/at.xml
	http://www.gentoo.org/proj/en/base/ppc/AT/index.xml
	http://www.gentoo.org/proj/en/base/amd64/at/index.xml
	http://www.gentoo.org/proj/en/base/alpha/AT/index.xml"
SRC_URI="mirror://sourceforge/gatt/${P}.tar.bz2"

LICENSE="GPL-2 GPL-3 FDL-1.2"
SLOT="0"
KEYWORDS="amd64 hppa ~ia64 ~ppc ~ppc64 sparc x86"
IUSE="doc libpaludis"

RDEPEND=">=dev-libs/boost-1.33.1
	>=dev-cpp/libthrowable-1.1.0
	www-client/pybugz
	libpaludis? ( >=sys-apps/paludis-0.26.0_alpha9 )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

pkg_setup() {
	ewarn "Gatt is targeted at Gentoo developers, arch-testers and power users. Do"
	ewarn "by no means use it if you are new to Gentoo. You have been warned!"
	ewarn
	elog "There is an Info manual shipped with some extensive examples".
	if use libpaludis && ! built_with_use sys-apps/paludis portage; then
		ewarn "You either have to emerge Paludis with USE=portage enabled or configure"
		ewarn "it properly before using Gatt with it."
	fi
}

src_compile() {
	econf $(use_enable libpaludis) || die
	emake || die
	use doc && doxygen
}
src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README NEWS AUTHORS ChangeLog

	if use doc; then
		dohtml doc/html/*
	fi
}
