# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Proc-ProcessTable/Proc-ProcessTable-0.39.ebuild,v 1.3 2004/07/14 20:17:44 agriffis Exp $

inherit perl-module

DESCRIPTION="Unix process table information"
SRC_URI="http://www.cpan.org/modules/by-authors/id/D/DU/DURIST/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/D/DU/DURIST/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~amd64 ~alpha ~hppa ~mips ~ppc ~sparc"
IUSE=""

SRC_TEST="do"
