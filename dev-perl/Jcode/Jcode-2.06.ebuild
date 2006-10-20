# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Jcode/Jcode-2.06.ebuild,v 1.5 2006/10/20 19:50:57 kloeri Exp $

inherit perl-module

DESCRIPTION="Japanese transcoding module for Perl"
SRC_URI="mirror://cpan/authors/id/D/DA/DANKOGAI/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-authors/id/D/DA/DANKOGAI/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~hppa ia64 ~ppc ~ppc64 sparc ~x86"
IUSE=""
SRC_TEST="do"

DEPEND=">=virtual/perl-MIME-Base64-2.1
	dev-lang/perl"
