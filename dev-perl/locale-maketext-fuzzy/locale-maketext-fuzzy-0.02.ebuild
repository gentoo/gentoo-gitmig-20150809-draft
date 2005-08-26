# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/locale-maketext-fuzzy/locale-maketext-fuzzy-0.02.ebuild,v 1.11 2005/08/26 01:12:34 agriffis Exp $

inherit perl-module

MY_P=Locale-Maketext-Fuzzy-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Maketext from already interpolated strings"
SRC_URI="mirror://cpan/authors/id/A/AU/AUTRIJUS/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/A/AU/AUTRIJUS/"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~hppa ~ia64 ppc sparc x86"
IUSE=""
