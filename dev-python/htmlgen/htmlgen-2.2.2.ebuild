# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/htmlgen/htmlgen-2.2.2.ebuild,v 1.4 2003/06/22 12:15:59 liquidx Exp $

IUSE=""
MY_P="HTMLgen"
DESCRIPTION="HTMLgen - Python modules for the generation of HTML documents"
HOMEPAGE="http://starship.python.net/crew/friedrich/HTMLgen/html/main.html"
SRC_URI="http://starship.python.net/crew/friedrich/${MY_P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/python
		dev-python/Imaging"

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
