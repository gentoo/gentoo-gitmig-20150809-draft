# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/stress/stress-0.18.1.ebuild,v 1.8 2004/11/03 19:31:04 corsair Exp $

MY_P=${PN}-${PV/_/}
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Imposes stressful loads on different aspects of the system."
HOMEPAGE="http://weather.ou.edu/~apw/projects/stress"
SRC_URI="http://weather.ou.edu/~apw/projects/stress/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86 ~sparc ppc ~ppc64"

DEPEND=""
RDEPEND=""

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install() {
	einstall
}
