# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Jcode/Jcode-2.06.ebuild,v 1.9 2007/03/05 12:08:35 ticho Exp $

inherit perl-module

DESCRIPTION="Japanese transcoding module for Perl"
HOMEPAGE="http://cpan.org/modules/by-authors/id/D/DA/DANKOGAI/${P}.readme"
SRC_URI="mirror://cpan/authors/id/D/DA/DANKOGAI/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ~ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=">=virtual/perl-MIME-Base64-2.1
	dev-lang/perl"

SRC_TEST="do"
