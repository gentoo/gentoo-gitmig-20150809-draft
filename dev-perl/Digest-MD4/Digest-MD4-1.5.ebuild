# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Digest-MD4/Digest-MD4-1.5.ebuild,v 1.12 2007/07/10 23:33:27 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="MD4 message digest algorithm"
HOMEPAGE="http://search.cpan.org/~mikem/"
SRC_URI="mirror://cpan/authors/id/M/MI/MIKEM/DigestMD4/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

SRC_TEST="do"
mydoc="README"

DEPEND="dev-lang/perl"
