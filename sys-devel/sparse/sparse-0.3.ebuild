# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/sparse/sparse-0.3.ebuild,v 1.1 2007/06/26 16:51:52 solar Exp $

inherit eutils

DESCRIPTION="C semantic parser"
HOMEPAGE="http://kernel.org/pub/linux/kernel/people/josh/sparse/"
SRC_URI="http://kernel.org/pub/linux/kernel/people/josh/sparse/dist/${P}.tar.gz"

LICENSE="OSL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~s390 ~sh ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"
	epatch "${FILESDIR}/${P}-makefile-fix.patch"
}

src_compile() {
	emake CFLAGS="${CFLAGS} -fpic" LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
#	emake install BINDIR="${D}"/usr/bin || die
#	newbin check sparse || die
#	dolib.so libsparse.so || die
	dodoc FAQ README
}
