# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/text-wrapper/text-wrapper-1.01.ebuild,v 1.9 2012/03/31 17:11:04 armin76 Exp $

inherit perl-module

MY_P=Text-Wrapper-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="The Perl Text::Wrapper Module"
SRC_URI="mirror://cpan/authors/id/C/CJ/CJM/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~cjm/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 hppa ppc ppc64 x86"
IUSE=""

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"
