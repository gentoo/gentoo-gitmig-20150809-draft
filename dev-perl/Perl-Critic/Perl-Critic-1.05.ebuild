# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Perl-Critic/Perl-Critic-1.05.ebuild,v 1.1 2007/04/04 14:59:38 yuval Exp $

inherit perl-module

MY_PV=${PV/%0/}
MY_P="${PN}-${MY_PV}"

S="${WORKDIR}/${MY_P}"

DESCRIPTION="Critique Perl source code for best-practices"
HOMEPAGE="http://search.cpan.org/~thaljef"
SRC_URI="mirror://cpan/authors/id/T/TH/THALJEF/perlcritic/${MY_P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"

RDEPEND=">=dev-perl/Module-Pluggable-3.1
	>=dev-perl/Config-Tiny-2
	dev-perl/List-MoreUtils
	dev-perl/IO-String
	dev-perl/String-Format
	dev-perl/perltidy
	>=dev-perl/PPI-1.118
	>=dev-perl/set-scalar-1.20
	dev-perl/B-Keywords
	dev-lang/perl"
DEPEND="dev-perl/module-build"
