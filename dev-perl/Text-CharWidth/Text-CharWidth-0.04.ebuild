# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-CharWidth/Text-CharWidth-0.04.ebuild,v 1.2 2006/01/13 17:57:53 mcummings Exp $

inherit perl-module

DESCRIPTION="Get number of occupied columns of a string on terminal"
SRC_URI="mirror://cpan/authors/id/K/KU/KUBOTA/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~kubota/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~sparc x86"

DEPEND=""
IUSE=""

SRC_TEST="do"
