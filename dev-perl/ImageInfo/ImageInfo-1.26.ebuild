# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ImageInfo/ImageInfo-1.26.ebuild,v 1.6 2008/11/18 15:09:33 tove Exp $

inherit perl-module

MY_P=Image-Info-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="The Perl Image-Info Module"
SRC_URI="mirror://cpan/authors/id/T/TE/TELS/image/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Image/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""
SRC_TEST="do"
PREFER_BUILDPL="no"

DEPEND=">=virtual/perl-Module-Build-0.28
	>=dev-perl/IO-String-1.01
	dev-lang/perl"
