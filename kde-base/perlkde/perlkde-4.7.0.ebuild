# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/perlkde/perlkde-4.7.0.ebuild,v 1.2 2011/08/02 21:47:07 dilfridge Exp $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KDE Perl bindings"
KEYWORDS="~amd64 ~x86"
IUSE="akonadi attica debug kate okular semantic-desktop test"

DEPEND="
	>=dev-lang/perl-5.10.1
	$(add_kdebase_dep perlqt)
	$(add_kdebase_dep smokekde 'akonadi?,attica?,kate?,okular?,semantic-desktop=')
	semantic-desktop? ( >=dev-libs/soprano-2.6.51 )
	test? ( dev-perl/List-MoreUtils )
"
RDEPEND="${DEPEND}"

# Split from kdebindings-perl in 4.7
add_blocker kdebindings-perl

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with akonadi)
		$(cmake-utils_use_with akonadi KdepimLibs)
		$(cmake-utils_use_with attica LibAttica)
		$(cmake-utils_use_disable kate)
		$(cmake-utils_use_with okular)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)
	)
	kde4-base_src_configure
}
