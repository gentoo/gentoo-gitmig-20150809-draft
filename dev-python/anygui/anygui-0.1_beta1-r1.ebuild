# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
#$Header $

pv="0.1b1"
S=${WORKDIR}/${PN}-${pv}
DESCRIPTION="Generic GUI Module for Python"
SRC_URI="mirror://sourceforge/anygui/${PN}-${pv}.tar.gz"
HOMEPAGE="http://anygui.sourceforge.net/"

DEPEND=">=dev-lang/python-2.0
	sys-libs/ncurses
        qt? ( =dev-python/PyQt-2.4* ) 
        gtk? ( dev-python/pygtk )
        tcltk? ( dev-lang/tk )"
RDEPEND="${DEPEND}"

#future: 
#       might need a wxw use variable for wxGTK for wxw? ( dev-python/wxPython )
#       also use variable fltk for fltk? ( dev-python/PyFLTK ) no ebuild for PyFLTK yet
#       java? ( dev-python/jython ) Java Swing (javagui) http://www.jython.org

SLOT="0"
KEYWORDS="x86"
LICENSE="MIT"

        
src_compile() {

        python setup.py build || die
        
}

src_install() {

        python setup.py install --prefix=${D}/usr || die 

        dodoc CHANGELOG.txt INSTALL.txt KNOWN_BUGS.txt LICENSE.txt \
                MAINTAINERS.txt  PKG-INFO README.txt TODO.txt VERSION.txt
        
}
