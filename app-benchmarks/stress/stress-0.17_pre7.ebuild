# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/stress/stress-0.17_pre7.ebuild,v 1.1 2002/12/08 17:58:15 method Exp $

DESCRIPTION="Imposes stressful loads on different aspects of the system."
HOMEPAGE="http://weather.ou.edu/~apw/projects/stress"

MY_PV=${PN}-${PV/_/}
SRC_URI="http://weather.ou.edu/~apw/projects/stress/${MY_PV}.tar.gz"
S="${WORKDIR}/${MY_PV}"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~x86 ~sparc"

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${MY_PV}.tar.gz
	cd ${WORKDIR}
}

src_compile() {

	./configure --prefix=/usr \
		--mandir=/usr/share/man || die

	emake || die
}

src_install() {
	einstall || die
}
