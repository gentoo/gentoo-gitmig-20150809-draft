# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PodParser/PodParser-1.22.ebuild,v 1.5 2004/02/09 22:21:16 darkspecter Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Print Usage messages based on your own pod"
SRC_URI="http://www.cpan.org/modules/by-authors/id/M/MA/MAREKR/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/M/MA/MAREKR/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ~alpha ppc sparc hppa ~mips"

DEPEND="dev-perl/File-Spec"
