# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mon/Mon-0.11-r1.ebuild,v 1.4 2002/07/25 04:13:27 seemant Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A Monitor Perl Module"
SRC_URI="http://www.cpan.org/modules/by-module/Mon/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mon/${P}.readme"

SLOT="0"
DEPEND="${DEPEND} >=dev-perl/Convert-BER-1.31 >=dev-perl/Net-Telnet-3.02"

RSLOT="0"
DEPEND="${DEPEND} >=net-analyzer/fping-2.2_beta1"

mydoc="COPYING COPYRIGHT VERSION"
