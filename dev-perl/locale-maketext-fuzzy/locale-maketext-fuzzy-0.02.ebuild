# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/locale-maketext-fuzzy/locale-maketext-fuzzy-0.02.ebuild,v 1.16 2007/07/10 23:33:26 mr_bones_ Exp $

inherit perl-module

MY_P=Locale-Maketext-Fuzzy-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Maketext from already interpolated strings"
SRC_URI="mirror://cpan/authors/id/A/AU/AUTRIJUS/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/A/AU/AUTRIJUS/"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE=""

DEPEND="dev-lang/perl"
