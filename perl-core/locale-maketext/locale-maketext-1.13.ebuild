# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/locale-maketext/locale-maketext-1.13.ebuild,v 1.7 2009/12/14 19:49:11 armin76 Exp $

inherit perl-module

MY_P=Locale-Maketext-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Localization framework for Perl programs"
HOMEPAGE="http://search.cpan.org/dist/Locale-Maketext/"
SRC_URI="mirror://cpan/authors/id/F/FE/FERREIRA/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~ppc s390 sh sparc x86"
IUSE=""

DEPEND="dev-lang/perl
	>=virtual/perl-i18n-langtags-0.30"

SRC_TEST="do"
