# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Image-Imlib2/Image-Imlib2-2.02.ebuild,v 1.3 2009/01/09 20:13:08 josejx Exp $

MODULE_AUTHOR=LBROCARD
inherit perl-module eutils

DESCRIPTION="Interface to the Imlib2 image library"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ppc sparc ~x86"
IUSE="test"

RDEPEND=">=media-libs/imlib2-1
	dev-lang/perl"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.28
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do

src_test(){
	if built_with_use media-libs/imlib2 jpeg png ; then
		perl-module_src_test
	else
		ewarn "Skip tests:"
		ewarn "To run tests install media-libs/imlib2 with jpeg and png support."
	fi
}
