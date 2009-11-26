# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Image-Imlib2/Image-Imlib2-2.03.ebuild,v 1.1 2009/11/26 07:58:58 robbat2 Exp $

EAPI="2"
MODULE_AUTHOR=LBROCARD
inherit perl-module eutils

DESCRIPTION="Interface to the Imlib2 image library"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="test"

RDEPEND=">=media-libs/imlib2-1
	dev-lang/perl"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.28
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
		>=media-libs/imlib2-1[jpeg,png]
	)"

SRC_TEST=do
