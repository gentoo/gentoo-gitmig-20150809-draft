# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Text-Balanced/Text-Balanced-1.98.ebuild,v 1.5 2006/10/20 20:53:54 mcummings Exp $

inherit perl-module

DESCRIPTION="Extract balanced-delimiter substrings"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/D/DC/DCONWAY/${P}.readme"
SRC_URI="mirror://cpan/authors/id/D/DC/DCONWAY/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl
	>=dev-perl/module-build-0.28"
