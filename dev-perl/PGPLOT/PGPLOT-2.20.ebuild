# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PGPLOT/PGPLOT-2.20.ebuild,v 1.4 2010/02/05 21:28:29 tove Exp $

EAPI=2

MODULE_AUTHOR=KGB
inherit perl-module

DESCRIPTION="allow subroutines in the PGPLOT graphics library to be called from Perl."

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

# Tests require active X display
#SRC_TEST="do"

RDEPEND="sci-libs/pgplot
	>=dev-perl/ExtUtils-F77-1.13"
DEPEND="${RDEPEND}"
