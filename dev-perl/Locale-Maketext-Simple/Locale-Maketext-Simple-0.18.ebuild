# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Locale-Maketext-Simple/Locale-Maketext-Simple-0.18.ebuild,v 1.3 2006/10/21 00:26:02 mcummings Exp $

inherit perl-module

DESCRIPTION="Locale::Maketext::Simple - Simple interface to Locale::Maketext::Lexicon"
SRC_URI="mirror://cpan/authors/id/A/AU/AUDREYT/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Locale/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="amd64 ~ia64 ~ppc sparc ~x86"
IUSE=""
SRC_TEST="do"


DEPEND="dev-lang/perl"
