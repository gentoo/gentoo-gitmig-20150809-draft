# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/wxPython/wxPython-2.3.2.1-r2.ebuild,v 1.3 2002/09/11 15:06:40 raker Exp $

S=${WORKDIR}/${P}

DESCRIPTION="A blending of the wxWindows C++ class library with Python."
SRC_URI="mirror://sourceforge/wxpython/${P}.tar.gz"
HOMEPAGE="http://www.wxpython.org/"

DEPEND=">=dev-lang/python-2.1
	=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	=x11-libs/wxGTK-2.3.2*
	opengl? ( >=dev-python/PyOpenGL-2.0.0.44 )"
RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 sparc sparc64"

src_unpack() {

	unpack ${A}
	cd ${S}/contrib/gizmos/contrib/src/gizmos
	patch -p0 < ${FILESDIR}/ledctrl.diff || die "patch failed"
	cd ${S}

}

src_compile() {

	local myconf
	myconf=""

#Other possible configuration variables are BUILD_OGL and BUILD_STC.
#BUILD_OGL builds the Object Graphics Library extension module.
#BUILD_STC builds the wxStyledTextCtrl (the Scintilla wrapper) extension module.
#Both these variable are enabled by default.  To disable them set equal to zero
#and add to myconf.

	if use opengl; then
		myconf="${myconf} BUILD_GLCANVAS=1"
	else
		myconf="${myconf} BUILD_GLCANVAS=0"
	fi
        
	python setup.py ${myconf} build || die
}

src_install () {

	python setup.py ${myconf} install --prefix=${D}/usr || die

	dodoc BUILD.unix.txt CHANGES.txt MANIFEST.in PKG-INFO README.txt
}
