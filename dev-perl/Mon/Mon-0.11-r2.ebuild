# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mon/Mon-0.11-r2.ebuild,v 1.12 2007/01/19 14:41:27 mcummings Exp $

inherit perl-module

DESCRIPTION="A Monitor Perl Module"
SRC_URI="mirror://cpan/authors/id/T/TR/TROCKIJ/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~trockij/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

DEPEND=">=net-analyzer/fping-2.2_beta1
	>=dev-perl/Convert-BER-1.31
	>=dev-perl/Net-Telnet-3.02
	>=dev-perl/Period-1.20
	dev-lang/perl"

mydoc="COPYING COPYRIGHT VERSION"
