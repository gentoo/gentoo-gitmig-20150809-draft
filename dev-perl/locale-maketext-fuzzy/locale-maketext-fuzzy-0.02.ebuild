# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/locale-maketext-fuzzy/locale-maketext-fuzzy-0.02.ebuild,v 1.17 2012/04/01 18:10:39 armin76 Exp $

inherit perl-module

MY_P=Locale-Maketext-Fuzzy-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Maketext from already interpolated strings"
SRC_URI="mirror://cpan/authors/id/A/AU/AUTRIJUS/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/A/AU/AUTRIJUS/"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 hppa ppc x86"
IUSE=""

DEPEND="dev-lang/perl"
