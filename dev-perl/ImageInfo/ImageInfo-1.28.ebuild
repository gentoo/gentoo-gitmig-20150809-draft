# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ImageInfo/ImageInfo-1.28.ebuild,v 1.4 2009/01/09 20:29:15 klausman Exp $

inherit perl-module

MY_P=Image-Info-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="The Perl Image-Info Module"
SRC_URI="mirror://cpan/authors/id/T/TE/TELS/image/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/dist/Image-Info/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha ~amd64 ~ia64 ~ppc ~ppc64 sparc ~x86"
IUSE=""

DEPEND=">=dev-perl/IO-String-1.01
	dev-perl/XML-Simple
	dev-lang/perl"

SRC_TEST="do"
