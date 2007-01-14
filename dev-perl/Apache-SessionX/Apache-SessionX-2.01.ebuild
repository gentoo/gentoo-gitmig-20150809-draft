# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-SessionX/Apache-SessionX-2.01.ebuild,v 1.9 2007/01/14 22:12:43 mcummings Exp $

inherit perl-module

IUSE=""

MY_PV=${PV/0_beta5/0b5}
MY_P="${PN}-${MY_PV}"
S=${WORKDIR}/${MY_P}

MY_PV=
DESCRIPTION="An extented persistence framework for session data"
SRC_URI="mirror://cpan/authors/id/G/GR/GRICHTER/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~grichter/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ia64 ~ppc sparc x86"

DEPEND="dev-perl/Apache-Session
	dev-lang/perl"

src_compile() {
	echo "n" | perl-module_src_compile
}
