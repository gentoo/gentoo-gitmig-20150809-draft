# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/File-Temp/File-Temp-0.14.ebuild,v 1.5 2006/02/04 14:30:39 solar Exp $

inherit perl-module

DESCRIPTION="File::Temp can be used to create and open temporary files in a safe way."
HOMEPAGE="http://www.cpan.org/modules/by-module/File/${P}.readme"
SRC_URI="mirror://cpan/authors/id/T/TJ/TJENNESS/${P}.tar.gz"
SRC_TEST="do"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""
