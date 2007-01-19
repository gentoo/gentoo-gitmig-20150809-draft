# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-IRC/Net-IRC-0.75.ebuild,v 1.11 2007/01/19 14:52:47 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl IRC module"
SRC_URI="mirror://cpan/authors/id/J/JM/JMUHLICH/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/search?module=Net::IRC"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

SRC_TEST="do"

mydoc="TODO"


DEPEND="dev-lang/perl"
