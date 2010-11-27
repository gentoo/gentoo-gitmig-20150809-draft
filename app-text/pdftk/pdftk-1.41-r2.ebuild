# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pdftk/pdftk-1.41-r2.ebuild,v 1.1 2010/11/27 22:16:39 xmw Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="A tool for manipulating PDF documents"
HOMEPAGE="http://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/"
SRC_URI="http://www.pdfhacks.com/pdftk/${P}.tar.gz
	http://aur.archlinux.org/packages/pdftk/pdftk/makefile.patch -> ${P}-makefile.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nodrm"

DEPEND=">=sys-devel/gcc-4.3.1[gcj]"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}/${PN}

src_prepare() {
	cd "${WORKDIR}" || die

	#bug #225709 and #251796
	epatch "${FILESDIR}/${P}-gcc-4.3.patch"

	#bug #269312
	epatch "${FILESDIR}/${P}-gcc-4.4.patch"

	#bug #209802
	epatch "${FILESDIR}/${P}-honor-ldflags.patch"

	cd "${S}"/.. || die
	#bug 339345
	epatch "${DISTDIR}/${P}-makefile.patch"

	# force usage of custom CFLAGS.
	sed -iorig 's:-O2:\$(CFLAGS):g' "${S}"/Makefile.Generic
	# nodrm patch, bug 296455
	if use nodrm; then
		sed -i 's:passwordIsOwner= false:passwordIsOwner= true:' "${WORKDIR}/${P}"/java_libs/com/lowagie/text/pdf/PdfReader.java || die
	fi

	sed -e '/^export GCJ=/d' -e '/^export GCJH=/d' \
		-i "${WORKDIR}"/${P}/${PN}/Makefile.Generic || die
}

src_compile() {
	# java-config settings break compilation by gcj.
	unset CLASSPATH
	unset JAVA_HOME

	tc-export GCJ
	export GCJH="${GCJ}"h

	# parallel make fails
	emake -j1 -f Makefile.Generic || die "Compilation failed."
}

src_install() {
	dobin pdftk || die
	newman ../debian/pdftk.1 pdftk.1 || die
	dohtml ../pdftk.1.html || die
}
