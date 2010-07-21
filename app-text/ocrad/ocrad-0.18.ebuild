# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ocrad/ocrad-0.18.ebuild,v 1.4 2010/07/21 19:37:55 ssuominen Exp $

inherit toolchain-funcs

DESCRIPTION="GNU Ocrad is an OCR (Optical Character Recognition) program"
HOMEPAGE="http://www.gnu.org/software/ocrad/ocrad.html"
SRC_URI="http://savannah.nongnu.org/download/ocrad/${P}.tar.lz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=""
DEPEND="app-arch/lzip"

src_unpack() {
	local i s
	for i in ${A}
	do
		s="${DISTDIR%/}/${i}"
		einfo "Unpacking ${s} to ${PWD}"
		test -s "${s}" || die "${s} does not exist"
		lzip -dc -- "${s}" | tar xof - || die "Unpacking ${s} failed"
	done
}

src_compile() {
	econf CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}"
	emake || die "emake failed."
}

src_test() {
	testsuite/check.sh testsuite || die "tests failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	doman doc/ocrad.1
	doinfo doc/ocrad.info
	dodoc AUTHORS NEWS README TODO
}
