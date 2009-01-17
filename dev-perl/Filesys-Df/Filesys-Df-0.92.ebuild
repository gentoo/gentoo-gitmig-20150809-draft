# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Filesys-Df/Filesys-Df-0.92.ebuild,v 1.4 2009/01/17 22:29:32 robbat2 Exp $

inherit perl-module

DESCRIPTION="Disk free based on Filesys::Statvfs"
HOMEPAGE="http://search.cpan.org/search?query=Filesys-Df&mode=dist"
SRC_URI="mirror://cpan/authors/id/I/IG/IGUTHRIE/${P}.tar.gz"

IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 x86"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
