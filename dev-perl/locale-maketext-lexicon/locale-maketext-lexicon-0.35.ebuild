# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/locale-maketext-lexicon/locale-maketext-lexicon-0.35.ebuild,v 1.12 2006/03/26 16:00:41 mcummings Exp $

inherit perl-module

MY_P=Locale-Maketext-Lexicon-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Use other catalog formats in Maketext"
HOMEPAGE="http://www.cpan.org/authors/id/A/AU/AUTRIJUS/"
SRC_URI="mirror://cpan/authors/id/A/AU/AUTRIJUS/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc alpha hppa amd64"
IUSE=""

DEPEND="virtual/perl-locale-maketext
		<virtual/perl-Test-Simple-0.48
	dev-perl/regexp-common"

SRC_TEST="do"
