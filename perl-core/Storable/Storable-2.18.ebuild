# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Storable/Storable-2.18.ebuild,v 1.5 2008/11/04 09:41:52 vapier Exp $

inherit perl-module

DESCRIPTION="The Perl Storable Module"
HOMEPAGE="http://www.cpan.org/modules/by-module/Storable/${P}.readme"
SRC_URI="mirror://cpan/authors/id/A/AM/AMS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha ~amd64 arm ~hppa ia64 ~mips ~ppc ~ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
