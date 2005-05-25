# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Proc-ProcessTable/Proc-ProcessTable-0.38.ebuild,v 1.10 2005/05/25 14:41:29 mcummings Exp $

inherit perl-module

DESCRIPTION="UNIX PROCESS TABLE INFORMATION"
HOMEPAGE="http://search.cpan.org/~durist/${P}/"
SRC_URI="mirror://cpan/authors/id/D/DU/DURIST/${P}.tar.gz"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 alpha ~hppa ~mips ppc ~sparc"
IUSE=""

DEPEND="perl-core/Storable"
