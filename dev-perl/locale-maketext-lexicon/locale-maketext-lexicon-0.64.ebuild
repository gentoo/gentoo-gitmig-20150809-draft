# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/locale-maketext-lexicon/locale-maketext-lexicon-0.64.ebuild,v 1.3 2007/07/11 16:36:47 armin76 Exp $

inherit perl-module

MY_P=Locale-Maketext-Lexicon-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Use other catalog formats in Maketext"
HOMEPAGE="http://www.cpan.org/authors/id/A/AU/AUDREYT/"
SRC_URI="mirror://cpan/authors/id/A/AU/AUDREYT/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha ~amd64 ~hppa ia64 ~ppc ~sparc x86"
IUSE=""

DEPEND="virtual/perl-locale-maketext
	dev-lang/perl"

SRC_TEST="do"
