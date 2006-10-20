# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-MMagic/File-MMagic-1.27.ebuild,v 1.7 2006/10/20 19:22:44 kloeri Exp $

inherit perl-module

DESCRIPTION="The Perl Image-Info Module"
SRC_URI="mirror://cpan/authors/id/K/KN/KNOK/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/File/${P}.readme"
SRC_TEST="do"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc ~x86"
IUSE=""


DEPEND="dev-lang/perl"
