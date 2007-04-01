# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-MethodMaker/Class-MethodMaker-2.08.ebuild,v 1.16 2007/04/01 22:16:33 tgall Exp $

inherit perl-module eutils

DESCRIPTION="Perl module for Class::MethodMaker"
HOMEPAGE="http://search.cpan.org/~fluffy"
SRC_URI="mirror://cpan/authors/id/F/FL/FLUFFY/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ~ppc64 s390 sh sparc x86"
IUSE=""

SRC_TEST="do"
PREFER_BUILDPL="no"


RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	>=dev-perl/module-build-0.28"
