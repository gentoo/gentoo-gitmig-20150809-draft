# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/wxPython/wxPython-2.3.2.1.ebuild,v 1.7 2002/08/16 02:49:58 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A blending of the wxWindows C++ class library with Python."
SRC_URI="mirror://sourceforge/wxpython/${P}.tar.gz"
HOMEPAGE="http://www.wxpython.org/"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND=">=dev-lang/python-2.1
	=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	x11-libs/wxGTK"
	#opengl? ( virtual/opengl )"
	#really need opengl? ( virtual/opengl dev-python/PyOpenGL )
	#to get full opengl functionality, i.e. wxGLCanvas.

src_compile() {

	#local myconf
	#myconf=""

#Other possible configuration variables are BUILD_OGL and BUILD_STC.
#BUILD_OGL builds the Object Graphics Library extension module.
#BUILD_STC builds the wxStyledTextCtrl (the Scintilla wrapper) extension 
module.
#Both these variable are enabled by default.  To disable them set equal to 
zero
#and add to myconf.

	#use opengl || myconf="${myconf} BUILD_GLCANVAS=0"
	#myconf="${myconf} BUILD_GLCANVAS=0"
	

	python setup.py build  ${myconf} || die
    
}

src_install () {
	
	python setup.py install --prefix=${D}/usr || die
	
	dodoc BUILD.unix.txt CHANGES.txt MANIFEST.in PKG-INFO README.txt
	
}
