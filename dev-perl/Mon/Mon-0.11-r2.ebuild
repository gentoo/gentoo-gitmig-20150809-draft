# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mon/Mon-0.11-r2.ebuild,v 1.3 2002/12/15 10:44:15 bjb Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A Monitor Perl Module"
SRC_URI="http://www.cpan.org/modules/by-module/Mon/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mon/${P}.readme"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="${DEPEND}
	>=net-analyzer/fping-2.2_beta1
	>=dev-perl/Convert-BER-1.31
	>=dev-perl/Net-Telnet-3.02
	>=dev-perl/Period-1.20"

mydoc="COPYING COPYRIGHT VERSION"
