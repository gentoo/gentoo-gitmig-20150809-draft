# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Convert-TNEF/Convert-TNEF-0.17-r2.ebuild,v 1.11 2005/04/24 22:20:06 mcummings Exp $

inherit perl-module

DESCRIPTION="A Perl module for reading TNEF files"
SCR_URI="mirror://cpan/authors/id/D/DO/DOUGW/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Convert/DOUGW/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha ppc64"
IUSE=""

DEPEND="${DEPEND}
	dev-perl/MIME-tools"
