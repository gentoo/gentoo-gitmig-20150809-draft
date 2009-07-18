# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/htmlgen/htmlgen-2.2.2.ebuild,v 1.15 2009/07/18 01:52:56 arfrever Exp $

EAPI="2"

inherit eutils python

MY_P="HTMLgen"
DESCRIPTION="HTMLgen - Python modules for the generation of HTML documents"
HOMEPAGE="http://starship.python.net/crew/friedrich/HTMLgen/html/main.html"
SRC_URI="http://starship.python.net/crew/friedrich/${MY_P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ia64 ppc x86"
IUSE="doc"

DEPEND="virtual/python
		dev-python/imaging"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/${P}-python-2.5.patch"
}

src_install() {
	python_need_rebuild

	# doing this manually because their build scripts suck
	local files="HTMLgen.py HTMLcolors.py HTMLutil.py HTMLcalendar.py \
	barchart.py colorcube.py imgsize.py NavLinks.py Formtools.py \
	ImageH.py ImageFileH.py ImagePaletteH.py GifImagePluginH.py \
	JpegImagePluginH.py PngImagePluginH.py"

	touch __init__.py

	insinto $(python_get_sitedir)/htmlgen
	doins $files __init__.py || die "doins failed"

	if use doc; then
		# fix the image locations in the docs
		sed -i -e "s;../image/;image/;g" html/* || die "sed failed"
		dohtml html/*
		dohtml -r image
	fi
	dodoc README
}

pkg_postinst() {
	python_mod_optimize $(python_get_sitedir)/htmlgen

	ewarn "htmlgen now resides in its own subdirectory"
	ewarn "so you need to do \"from htmlgen import HTMLgen\" instead of \"import HTMLgen\""
}

pkg_postrm () {
	python_mod_cleanup $(python_get_sitedir)/htmlgen
}
