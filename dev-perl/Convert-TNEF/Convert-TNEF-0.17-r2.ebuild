# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Convert-TNEF/Convert-TNEF-0.17-r2.ebuild,v 1.13 2005/08/26 02:14:20 agriffis Exp $

inherit perl-module

DESCRIPTION="A Perl module for reading TNEF files"
SRC_URI="mirror://cpan/authors/id/D/DO/DOUGW/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Convert/DOUGW/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ~ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="${DEPEND}
	dev-perl/MIME-tools"
