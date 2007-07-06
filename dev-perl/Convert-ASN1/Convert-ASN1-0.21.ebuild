# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Convert-ASN1/Convert-ASN1-0.21.ebuild,v 1.8 2007/07/06 14:18:23 tgall Exp $

inherit perl-module

DESCRIPTION="Standard en/decode of ASN.1 structures"
HOMEPAGE="http://search.cpan.org/~gbarr/"
SRC_URI="mirror://cpan/authors/id/G/GB/GBARR/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

SRC_TEST="do"
DEPEND="dev-lang/perl"
