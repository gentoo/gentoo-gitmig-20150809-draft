# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Storable/Storable-2.16.ebuild,v 1.10 2009/12/16 21:56:41 abcd Exp $

inherit perl-module

DESCRIPTION="The Perl Storable Module"
HOMEPAGE="http://www.cpan.org/modules/by-module/Storable/${P}.readme"
SRC_URI="mirror://cpan/authors/id/A/AM/AMS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
