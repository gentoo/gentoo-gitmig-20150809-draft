# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mon/Mon-0.11-r1.ebuild,v 1.2 2002/05/21 18:14:07 danarmak Exp $


inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A Monitor Perl Module"
SRC_URI="http://www.cpan.org/modules/by-module/Mon/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mon/${P}.readme"

DEPEND="${DEPEND}
	>=dev-perl/Convert-BER-1.31
	>=dev-perl/Net-Telnet-3.02"

RDEPEND="${DEPEND}
	>=net-misc/fping-2.2_beta1"

mydoc="COPYING COPYRIGHT VERSION"
