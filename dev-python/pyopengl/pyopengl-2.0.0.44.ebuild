# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyopengl/pyopengl-2.0.0.44.ebuild,v 1.15 2007/02/03 08:24:57 lucass Exp $

MY_P=${P/pyopengl/PyOpenGL}
S=${WORKDIR}/${MY_P}

inherit eutils distutils

DESCRIPTION="Python OpenGL bindings"
HOMEPAGE="http://pyopengl.sourceforge.net/"
SRC_URI="mirror://sourceforge/pyopengl/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86"
IUSE=""

DEPEND="virtual/python
	virtual/glut
	|| ( ( x11-libs/libXi
			x11-libs/libXmu
		)
		virtual/x11
	)
	virtual/opengl"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/config.diff
	epatch ${FILESDIR}/${P}-fix_togl.patch

	sed -e 's/self\.NUMERIC/self.HAS_NUMERIC/' -i setup/dist.py

	if built_with_use dev-lang/python tk; then
		tkv=$(grep TK_VER /usr/include/tk.h | sed 's/^.*"\(.*\)".*/\1/')
		TKLIBRARY="'\/usr\/$(get_libdir)\/tk${tkv}'"
		tclv=$(grep TCL_VER /usr/include/tcl.h | sed 's/^.*"\(.*\)".*/\1/')
		TCLLIBRARY="'\/usr\/$(get_libdir)\/tcl${tclv}'"
		TKEQ="True"
	else
		TKLIBRARY="'/usr/lib/'"
		TCLLIBRARY="'/usr/lib/'"
		TKEQ="None"
	fi
	SEDED="""
s:tk = Tkinter.Tk():tk = ${TKEQ}:;
s:tk.getvar('tk_version'):str(Tkinter.TkVersion):g;
s:tk.getvar( 'tk_version' ):str(Tkinter.TkVersion):g;
s:tk.getvar('tcl_version'):str(Tkinter.TclVersion):g;
s:tk.getvar('tk_library'):${TKLIBRARY}:g;
s:tk.getvar('tcl_library'):${TCLLIBRARY}:g;"""
	sed -i -e "${SEDED}" setup/togl_setup.py
}
