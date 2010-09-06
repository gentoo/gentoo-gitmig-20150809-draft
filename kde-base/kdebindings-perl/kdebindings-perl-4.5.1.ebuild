# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebindings-perl/kdebindings-perl-4.5.1.ebuild,v 1.2 2010/09/06 04:50:56 reavertm Exp $

EAPI="2"

KMNAME="kdebindings"
KMMODULE="perl"
inherit kde4-meta

DESCRIPTION="KDE Perl bindings"
KEYWORDS="~amd64 ~x86"
IUSE="debug plasma"

DEPEND="
	$(add_kdebase_dep smoke)
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_disable plasma)
	)
	kde4-meta_src_configure
}
