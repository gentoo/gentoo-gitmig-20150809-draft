# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/tex4ht/tex4ht-20050406_p1623.ebuild,v 1.1 2005/04/07 05:28:11 usata Exp $

inherit toolchain-funcs

IUSE=""

# tex4ht-20050331_p2350 -> tex4ht-1.0.2005_03_31_2350
MY_P="${PN}-1.0.${PV:0:4}_${PV:4:2}_${PV:6:2}_${PV/*_p/}"

DESCRIPTION="Converts (La)TeX to (X)HTML, XML and OO.org"
HOMEPAGE="http://www.cse.ohio-state.edu/~gurari/TeX4ht/"
SRC_URI="http://www.cse.ohio-state.edu/~gurari/TeX4ht/fix/${MY_P}.tar.gz"

LICENSE="LPPL-1.2"
KEYWORDS="~x86 ~ppc ~amd64"
SLOT="0"

DEPEND="virtual/tetex
	>=sys-apps/sed-4"

RDEPEND="virtual/tetex
	virtual/ghostscript
	media-gfx/imagemagick"

S="${WORKDIR}/${MY_P}"

src_unpack() {

	unpack ${A}
	cd ${S}/texmf/tex4ht/base/unix
	sed -i -e \
	's#~/tex4ht.dir#/usr/share#' tex4ht.env || die
	sed -i -e \
	's#tpath/tex/texmf/fonts/tfm/!#t/usr/share/texmf/fonts/tfm/!\nt/usr/local/share/texmf/fonts/tfm/!\nt/var/cache/fonts/tfm/!#' tex4ht.env || die

}

src_compile() {

	cd ${S}/src/
	einfo "Compiling postprocessor sources..."
	for f in tex4ht t4ht htcmd ; do
		$(tc-getCC) -o $f $f.c \
			-DENVFILE='"/usr/share/texmf/tex4ht/base/tex4ht.env"' \
			-DHAVE_DIRENT_H -DKPATHSEA -lkpathsea \
			|| die "Compiling $f failed"
	done

}

src_install () {

	# install the binaries
	dobin ${S}/src/tex4ht ${S}/src/t4ht ${S}/src/htcmd
	dobin ${S}/bin/unix/*

	# install the .4ht scripts
	insinto /usr/share/texmf/tex/generic/tex4ht
	doins ${S}/texmf/tex/generic/tex4ht/*

	# install the special htf fonts
	dodir /usr/share/texmf/tex4ht
	cp -a ${S}/texmf/tex4ht/ht-fonts ${D}/usr/share/texmf/tex4ht

	# install the env file
	insinto /usr/share/texmf/tex4ht/base
	newins ${S}/texmf/tex4ht/base/unix/tex4ht.env tex4ht.env

	# this dir is 700 in the zip
	fperms 755 /usr/share/texmf/tex4ht/ht-fonts

}

pkg_postinst () {

	einfo "Running mktexlsr to rebuild file databases..."
	mktexlsr

}

pkg_postrm () {

	einfo "Running mktexlsr to rebuild file databases..."
	mktexlsr

}
