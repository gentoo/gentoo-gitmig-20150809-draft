# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xxdiff/xxdiff-3.2-r1.ebuild,v 1.8 2009/11/12 17:13:22 ssuominen Exp $

EAPI=1
inherit distutils eutils toolchain-funcs qt3

DESCRIPTION="A graphical file and directories comparator and merge tool."
HOMEPAGE="http://furius.ca/xxdiff/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86 ~x86-fbsd"
IUSE="python debug"

COMMON_DEPEND="x11-libs/qt:3"
RDEPEND="${COMMON_DEPEND}
	sys-apps/diffutils"
DEPEND="${COMMON_DEPEND}
	sys-devel/flex
	|| ( sys-devel/bison dev-util/yacc )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch #214181

	use debug || sed -i -e '/CONFIG/s:debug::' "${S}/src/xxdiff.pro"

	# The getopt replacements used here are a bit of a moot point for
	# some systems, and they are also causing warnings. Remove them when
	# they are not needed.
	if use elibc_glibc || use elibc_uclibc || use elibc_FreeBSD; then
		rm "${S}"/src/getopt{1.c,.c,.h} || die "unable to remove getopt"
		sed -i -e '/getopt/d' "${S}/src/xxdiff.pro" || die "unable to remove getopt"
	fi
}

src_compile() {
	use python && distutils_src_compile

	cd src
	emake -f Makefile.bootstrap makefile || die
	emake \
		CC="$(tc-getCC) ${CFLAGS}" \
		CXX="$(tc-getCXX) ${CXXFLAGS}" \
		LINK="$(tc-getCXX) ${LDFLAGS}" \
		|| die
	cd ../doc
	emake || die

}

src_install () {
	use python && distutils_src_install
	dobin bin/xxdiff bin/xx-cvs-diff bin/xx-encrypted bin/xx-find-grep-sed bin/xx-match
	doman src/xxdiff.1
	dodoc README CHANGES TODO
	dohtml doc/xxdiff-doc.html
}
