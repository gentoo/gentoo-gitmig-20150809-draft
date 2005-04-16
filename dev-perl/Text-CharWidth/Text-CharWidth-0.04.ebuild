# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-CharWidth/Text-CharWidth-0.04.ebuild,v 1.1 2005/04/16 22:16:06 mcummings Exp $

inherit perl-module

DESCRIPTION="Get number of occupied columns of a string on terminal"
SRC_URI="mirror://cpan/authors/id/K/KU/KUBOTA/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~kubota/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~sparc"

DEPEND=""
IUSE=""

SRC_TEST="do"
