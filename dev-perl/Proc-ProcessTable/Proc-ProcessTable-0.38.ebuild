# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Proc-ProcessTable/Proc-ProcessTable-0.38.ebuild,v 1.11 2006/02/13 14:01:52 mcummings Exp $

inherit perl-module

DESCRIPTION="UNIX PROCESS TABLE INFORMATION"
HOMEPAGE="http://search.cpan.org/~durist/${P}/"
SRC_URI="mirror://cpan/authors/id/D/DU/DURIST/${P}.tar.gz"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 alpha ~hppa ~mips ppc ~sparc"
IUSE=""

DEPEND="virtual/perl-Storable"
