# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/tex4ht/tex4ht-20040212.ebuild,v 1.3 2004/11/21 06:12:53 kingtaco Exp $

IUSE=""

DESCRIPTION="Converts (La)TeX to (X)HTML, XML and OO.org"
HOMEPAGE="http://www.cse.ohio-state.edu/~gurari/TeX4ht/"
SRC_URI="http://www.cse.ohio-state.edu/~gurari/TeX4ht/${P}.zip"

LICENSE="LPPL-1.2"
KEYWORDS="~x86 ~ppc ~amd64"
SLOT="0"

DEPEND="virtual/tetex
	app-arch/unzip
	>=sys-apps/sed-4"

RDEPEND="virtual/tetex
	virtual/ghostscript
	media-gfx/imagemagick"

S="${WORKDIR}"

src_unpack() {

	unpack ${P}.zip > /dev/null
	cd ${WORKDIR}/texmf/tex4ht/base/unix
	sed -i -e \
	's#~/tex4ht.dir#/usr/share#' tex4ht.env || die
	sed -i -e \
	's#tpath/tex/texmf/fonts/tfm/!#t/usr/share/texmf/fonts/tfm/!\nt/usr/local/share/texmf/fonts/tfm/!\nt/var/cache/fonts/tfm/!#' tex4ht.env || die

}

src_compile() {

	cd ${WORKDIR}/temp/
	einfo "Compiling postprocessor sources..."
	gcc -o tex4ht tex4ht.c -DENVFILE='"/usr/share/texmf/tex4ht/base/tex4ht.env"' -DHAVE_DIRENT_H \
	-DKPATHSEA -lkpathsea || die "Compiling tex4ht failed"
	gcc -o t4ht t4ht.c -DENVFILE='"/usr/share/texmf/tex4ht/base/tex4ht.env"' \
	-DKPATHSEA -lkpathsea || die "Compiling t4ht failed"

}

src_install () {

	# install the binaries
	exeinto /usr/bin
	doexe ${WORKDIR}/temp/tex4ht ${WORKDIR}/temp/t4ht
	doexe ${WORKDIR}/bin/unix/*

	# install the .4ht scripts
	insinto /usr/share/texmf/tex/generic/tex4ht
	doins ${WORKDIR}/texmf/tex/generic/tex4ht/*

	# install the special htf fonts
	dodir /usr/share/texmf/tex4ht
	cp -a ${WORKDIR}/texmf/tex4ht/ht-fonts ${D}/usr/share/texmf/tex4ht

	# install the env file
	insinto /usr/share/texmf/tex4ht/base
	newins ${WORKDIR}/texmf/tex4ht/base/unix/tex4ht.env tex4ht.env

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
