# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Glob/Text-Glob-0.06.ebuild,v 1.3 2004/05/07 17:43:18 gustavoz Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Match globbing patterns against text"
SRC_URI="http://www.cpan.org/modules/by-authors/id/R/RC/RCLAMP/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/R/RC/RCLAMP/${P}.readme"

SRC_TEST="do"
SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ~alpha ~hppa ~ppc sparc ~mips"

DEPEND="dev-perl/Test-Simple"

