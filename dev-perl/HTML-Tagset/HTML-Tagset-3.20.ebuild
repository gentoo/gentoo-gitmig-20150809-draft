# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Tagset/HTML-Tagset-3.20.ebuild,v 1.4 2008/11/04 10:20:27 vapier Exp $

inherit perl-module

DESCRIPTION="data tables useful in parsing HTML"
SRC_URI="mirror://cpan/authors/id/P/PE/PETDANCE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/search?module=${PN}"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha ~amd64 arm ~hppa ia64 m68k ~mips ~ppc ~ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
