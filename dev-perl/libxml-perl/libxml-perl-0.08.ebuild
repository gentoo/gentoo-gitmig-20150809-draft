# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libxml-perl/libxml-perl-0.08.ebuild,v 1.8 2005/08/23 16:18:05 agriffis Exp $

inherit perl-module

DESCRIPTION="Collection of Perl modules for working with XML"
SRC_URI="mirror://cpan/modules/by-module/XML/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/modules/by-module/XML/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha ~amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="${DEPEND}
	>=dev-perl/XML-Parser-2.29"
