# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Perl-Critic/Perl-Critic-0.20.ebuild,v 1.2 2006/09/13 20:41:00 yuval Exp $

inherit perl-module

MY_PV=${PV/%0/}
MY_P="${PN}-${MY_PV}"

S="${WORKDIR}/${MY_P}"

DESCRIPTION="Critique Perl source code for best-practices"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/T/TH/THALJEF/perlcritic/${MY_P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Module-Pluggable
	dev-perl/Config-Tiny
		dev-perl/List-MoreUtils
		dev-perl/IO-String
		dev-perl/String-Format
		dev-perl/perltidy
		>=dev-perl/PPI-1.117
	dev-lang/perl"
RDEPEND="${DEPEND}"

