# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Tree/HTML-Tree-3.21.ebuild,v 1.6 2006/10/21 14:16:43 dertobi123 Exp $

inherit perl-module

DESCRIPTION="A library to manage HTML-Tree in PERL"
HOMEPAGE="http://search.cpan.org/dist/${P}/"
SRC_URI="mirror://cpan/authors/id/P/PE/PETEK/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 m68k ~mips ppc ~ppc64 s390 sh sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-perl/HTML-Tagset-3.03
	>=dev-perl/HTML-Parser-2.19
	dev-lang/perl"

SRC_TEST="do"

mydoc="Changes MANIFEST README"
