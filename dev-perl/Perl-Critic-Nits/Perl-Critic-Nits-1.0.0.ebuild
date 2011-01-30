# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Perl-Critic-Nits/Perl-Critic-Nits-1.0.0.ebuild,v 1.1 2011/01/30 23:32:26 idl0r Exp $

EAPI="3"

MODULE_AUTHOR="KCOWGILL"
MY_P="${PN}-v${PV}"

inherit perl-module

DESCRIPTION="policies of nits I like to pick"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}
	dev-perl/Perl-Critic"

SRC_URI="mirror://cpan/authors/id/K/KC/KCOWGILL/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"
