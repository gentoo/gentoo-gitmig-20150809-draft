# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/sparse/sparse-2006.09.23.ebuild,v 1.1 2006/09/23 07:04:58 vapier Exp $

MY_PV=${PV//./-}
MY_PV2=${PV//./}

DESCRIPTION="C semantic parser"
HOMEPAGE="http://kernel.org/pub/scm/devel/sparse/"
SRC_URI="http://www.codemonkey.org.uk/projects/git-snapshots/sparse/${PN}-${MY_PV}.tar.gz"

LICENSE="OSL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/git-snapshot-${MY_PV2}

src_compile() {
	emake CFLAGS="${CFLAGS} -fpic" LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	newbin check sparse || die
	dolib.so libsparse.so || die
	dodoc FAQ README
}
