# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mon/Mon-0.11-r1.ebuild,v 1.3 2002/07/08 04:44:48 drobbins Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A Monitor Perl Module"
SRC_URI="http://www.cpan.org/modules/by-module/Mon/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mon/${P}.readme"

DEPEND="${DEPEND} >=dev-perl/Convert-BER-1.31 >=dev-perl/Net-Telnet-3.02"

RDEPEND="${DEPEND} >=net-analyzer/fping-2.2_beta1"

mydoc="COPYING COPYRIGHT VERSION"
