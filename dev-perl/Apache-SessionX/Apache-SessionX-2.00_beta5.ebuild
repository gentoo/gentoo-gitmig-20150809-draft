# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-SessionX/Apache-SessionX-2.00_beta5.ebuild,v 1.4 2006/07/03 20:11:24 ian Exp $

inherit perl-module

IUSE=""

MY_PV=${PV/0_beta5/0b5}
MY_P="${PN}-${MY_PV}"
S=${WORKDIR}/${MY_P}

MY_PV=
DESCRIPTION="An extented persistence framework for session data"
SRC_URI="mirror://cpan/authors/id/G/GR/GRICHTER/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~grichter/${MY_P}"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~sparc x86 ~ppc"

DEPEND="dev-perl/Apache-Session"
RDEPEND="${DEPEND}"

src_compile() {
	echo "n" | perl-module_src_compile
}