# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-ClassAPI/Test-ClassAPI-1.02.ebuild,v 1.2 2004/11/30 21:52:32 swegener Exp $

inherit perl-module

DESCRIPTION="Provides basic first-pass API testing for large class trees"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~adamk/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64 ~alpha ~hppa ~mips ~ppc ~sparc"
IUSE=""

DEPEND=">=dev-perl/File-Spec-0.83
		dev-perl/Test-Simple
		>=dev-perl/Class-Inspector-1.06
		dev-perl/Config-Tiny"
