# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Getopt-Long/Getopt-Long-2.34.ebuild,v 1.1 2003/12/26 01:46:11 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Advanced handling of command line options"
SRC_URI="http://www.cpan.org/modules/by-authors/id/J/JV/JV/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/J/JV/JV/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ~alpha ~ppc ~sparc"

DEPEND="dev-perl/PodParser"

