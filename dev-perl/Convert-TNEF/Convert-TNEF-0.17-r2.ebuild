# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Convert-TNEF/Convert-TNEF-0.17-r2.ebuild,v 1.8 2004/07/14 17:00:35 agriffis Exp $

inherit perl-module

DESCRIPTION="A Perl module for reading TNEF files"
SRC_URI="http://www.cpan.org/modules/by-module/Convert/DOUGW/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Convert/DOUGW/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

DEPEND="${DEPEND}
	dev-perl/MIME-tools"
