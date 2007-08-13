# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xxdiff/xxdiff-3.2-r1.ebuild,v 1.3 2007/08/13 20:52:44 dertobi123 Exp $

inherit distutils eutils kde-functions toolchain-funcs

DESCRIPTION="A graphical file and directories comparator and merge tool."
HOMEPAGE="http://xxdiff.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ia64 ppc ~sparc x86 ~x86-fbsd"
IUSE="kde python debug"

RDEPEND="=x11-libs/qt-3*
	kde? ( >=kde-base/kdelibs-3.1 )"

DEPEND="${RDEPEND}
	sys-devel/flex
	|| ( sys-devel/bison dev-util/yacc )"

RDEPEND="${RDEPEND}
	sys-apps/diffutils"

set-kdedir 3

src_unpack() {
	unpack ${A}

	if use kde; then
		cd "${S}/src"
		epatch "${FILESDIR}/${P}-kdesupport.patch"
		sed -i "s:/usr/include/kde:${KDEDIR}/include:g" xxdiff.pro
		sed -i "s:QMAKE_LIBS +=:QMAKE_LIBS+= -L${KDEDIR}/lib:g" xxdiff.pro
	fi

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
	if use python; then
		distutils_src_compile
	fi

	cd src
	make -f Makefile.bootstrap makefile || die "Makefile creation failed"
	emake \
		CC="$(tc-getCC) ${CFLAGS}" \
		CXX="$(tc-getCXX) ${CXXFLAGS}" \
		LINK="$(tc-getCXX) ${LDFLAGS}" \
		|| die "make failed"
	cd ../doc
	emake || die "Doc failed"

}

src_install () {
	if use python; then
		distutils_src_install
	fi

	dobin bin/xxdiff bin/xx-cvs-diff bin/xx-encrypted bin/xx-find-grep-sed bin/xx-match
	doman src/xxdiff.1
	dodoc README CHANGES TODO
	cd doc
	dodoc xxdiff-doc.html
}
