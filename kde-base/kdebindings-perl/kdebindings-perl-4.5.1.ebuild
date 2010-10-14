# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebindings-perl/kdebindings-perl-4.5.1.ebuild,v 1.5 2010/10/14 23:36:01 dilfridge Exp $

EAPI="2"

KMNAME="kdebindings"
KMMODULE="perl"
inherit kde4-meta

DESCRIPTION="KDE Perl bindings"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug plasma"

DEPEND="
	$(add_kdebase_dep smoke)
	>=dev-lang/perl-5.10.1
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_disable plasma)
	)
	kde4-meta_src_configure
}
