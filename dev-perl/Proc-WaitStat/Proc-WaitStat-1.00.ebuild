# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Proc-WaitStat/Proc-WaitStat-1.00.ebuild,v 1.9 2007/01/19 15:40:30 mcummings Exp $

inherit perl-module

DESCRIPTION="Interpret and act on wait() status values"
SRC_URI="mirror://cpan/authors/id/R/RO/ROSCH/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rosch/"

IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ia64 x86"

SRC_TEST="do"
DEPEND="dev-perl/IPC-Signal
	dev-lang/perl"
