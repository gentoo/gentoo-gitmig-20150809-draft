# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/htmlgen/htmlgen-2.2.2.ebuild,v 1.8 2004/07/19 22:01:44 kloeri Exp $

IUSE=""
MY_P="HTMLgen"
DESCRIPTION="HTMLgen - Python modules for the generation of HTML documents"
HOMEPAGE="http://starship.python.net/crew/friedrich/HTMLgen/html/main.html"
SRC_URI="http://starship.python.net/crew/friedrich/${MY_P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/python
		dev-python/imaging"

S="${WORKDIR}/${MY_P}"

src_compile() {
	make compileall || die "make failed"
}

src_install() {
	PYTHON_VER=$(python -V 2>&1 | sed -e 's:Python \([0-9].[0-9]\).*:\1:')
	# doing this manually because their build scripts suck
	dodir /usr/lib/python${PYTHON_VER}/site-packages
	insinto /usr/lib/python${PYTHON_VER}/site-packages
	doins HTMLgen.py HTMLcolors.py HTMLutil.py HTMLcalendar.py
	doins barchart.py colorcube.py imgsize.py NavLinks.py
	doins Formtools.py HTMLgen.pyc HTMLcolors.pyc HTMLutil.pyc
	doins HTMLcalendar.pyc barchart.pyc colorcube.pyc imgsize.pyc
	doins NavLinks.pyc Formtools.pyc ImageH.py ImageFileH.py
	doins ImagePaletteH.py GifImagePluginH.py JpegImagePluginH.py
	doins PngImagePluginH.py ImageH.pyc ImageFileH.pyc
	doins ImagePaletteH.pyc GifImagePluginH.pyc JpegImagePluginH.pyc
	doins PngImagePluginH.pyc
}
