# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ImageSize/ImageSize-3.1.1.ebuild,v 1.1 2008/08/09 10:37:14 tove Exp $

inherit perl-module

MY_P=Image-Size-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="The Perl Image-Size Module"
HOMEPAGE="http://search.cpan.org/dist/Image-Size/"
SRC_URI="mirror://cpan/authors/id/R/RJ/RJRAY/${MY_P}.tar.gz"

LICENSE="|| ( Artistic-2 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="test"
SRC_TEST="do"
mydoc="ToDo"

RDEPEND="dev-lang/perl
	dev-perl/Compress-Zlib
	virtual/perl-File-Spec"
DEPEND="${RDEPEND}
	>=dev-perl/module-build-0.28
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"
