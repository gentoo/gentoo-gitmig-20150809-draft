# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/glpk/glpk-4.7.ebuild,v 1.1 2004/11/22 02:43:28 robbat2 Exp $

DESCRIPTION="GNU Linear Programming Kit"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/glpk/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="doc"

RDEPEND="sys-libs/glibc"
DEPEND=">=sys-devel/gcc-3.2* ${RDEPEND}
		 doc? ( virtual/ghostscript )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e "s:/usr/local/lib:${S}/src:g" -i contrib/jni/c/Makefile \
		|| die "sed failed correcting library path"
}

src_compile() {
	LIBS="${LIBS} -lm" econf --enable-shared || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	# base docs
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
	#examples
	docinto examples

	dodoc ${S}/examples/*
	#docs
	if use doc; then
		cd ${S}/doc
		for i in *.ps; do
			ps2pdf14 ${i}
		done
	fi
	dodoc ${S}/doc/*
}
