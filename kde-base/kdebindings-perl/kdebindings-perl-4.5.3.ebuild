# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebindings-perl/kdebindings-perl-4.5.3.ebuild,v 1.1 2010/11/03 16:30:20 scarabeus Exp $

EAPI="2"

KMNAME="kdebindings"
KMMODULE="perl"
inherit kde4-meta

DESCRIPTION="KDE Perl bindings"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug plasma"

DEPEND="
	>=dev-lang/perl-5.10.1
	$(add_kdebase_dep smoke)
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_disable plasma)
	)
	kde4-meta_src_configure
}
