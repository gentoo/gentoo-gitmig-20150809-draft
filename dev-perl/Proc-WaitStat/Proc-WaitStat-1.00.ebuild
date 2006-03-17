# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Proc-WaitStat/Proc-WaitStat-1.00.ebuild,v 1.3 2006/03/17 03:52:20 deltacow Exp $

inherit perl-module

DESCRIPTION="Interpret and act on wait() status values"
SRC_URI="mirror://cpan/authors/id/R/RO/ROSCH/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/~rosch/${P}/"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 x86"

DEPEND="dev-perl/IPC-Signal"
