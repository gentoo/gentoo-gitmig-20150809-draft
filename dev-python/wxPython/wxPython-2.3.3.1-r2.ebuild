# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wxPython/wxPython-2.3.3.1-r2.ebuild,v 1.6 2003/02/13 11:39:56 vapier Exp $

MY_P="${P/-/Src-}"
S="${WORKDIR}/${MY_P}/${PN}"
DESCRIPTION="A blending of the wxWindows C++ class library with Python."
SRC_URI="mirror://sourceforge/wxpython/${MY_P}.tar.gz"
HOMEPAGE="http://www.wxpython.org/"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ppc sparc alpha"
IUSE="opengl"

DEPEND=">=dev-lang/python-2.1
        =dev-libs/glib-1.2*
        =x11-libs/gtk+-1.2*
        =x11-libs/wxGTK-2.3.3*
        opengl? ( >=dev-python/PyOpenGL-2.0.0.44 )"

pkg_setup() {
	# xfree should not install these, remove until the fixed
	# xfree is in main use.
	rm -f /usr/X11R6/include/{zconf.h,zlib.h}
}

src_compile() {
	# create links so the build doesnt fail
	for d in ogl stc xrc gizmos ; do
		ln -s ${S}/../contrib/ ${S}/contrib/${d}/contrib
	done

	#Other possible configuration variables are BUILD_OGL and BUILD_STC.
	#BUILD_OGL builds the Object Graphics Library extension module.
	#BUILD_STC builds the wxStyledTextCtrl (the Scintilla wrapper) extension module.
	#Both these variable are enabled by default.  To disable them set equal to zero
	#and add to myconf.

	local myconf=""
	if [ `use opengl` ] ; then
		myconf="${myconf} BUILD_GLCANVAS=1"
	else
		myconf="${myconf} BUILD_GLCANVAS=0"
		patch -p1 < ${FILESDIR}/${P}-noglcanvas.diff || die "patch failed"
	fi

	python setup.py ${myconf} build || die "build failed ... make sure you compiled wxGTK with all the graphic libraries enabled via USE (jpeg png opengl gif tiff zlib gtk X)"
}

src_install() {
	python setup.py install --prefix=/usr --root=${D} || die
}
