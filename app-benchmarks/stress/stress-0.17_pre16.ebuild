# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/stress/stress-0.17_pre16.ebuild,v 1.1 2003/04/28 19:50:04 method Exp $

MY_P=${PN}-${PV/_/}
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Imposes stressful loads on different aspects of the system."
HOMEPAGE="http://weather.ou.edu/~apw/projects/stress"
SRC_URI="http://weather.ou.edu/~apw/projects/stress/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~x86 ~sparc ~ppc"

DEPEND=""
RDEPEND=""

src_compile() {
	econf
	emake || die
}

src_install() {
	einstall
}
