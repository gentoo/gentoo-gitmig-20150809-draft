# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wxPython/wxPython-2.4.0.2.ebuild,v 1.3 2003/06/21 22:30:25 drobbins Exp $

MY_P="${P/-/Src-}"
S="${WORKDIR}/${MY_P}/${PN}"
DESCRIPTION="A blending of the wxWindows C++ class library with Python."
SRC_URI="mirror://sourceforge/wxpython/${MY_P}.tar.gz"
HOMEPAGE="http://www.wxpython.org/"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 amd64 ~ppc ~sparc ~alpha"
IUSE="opengl gtk2"

DEPEND=">=dev-lang/python-2.1
        >=dev-libs/glib-1.2
        >=x11-libs/gtk+-1.2
        =x11-libs/wxGTK-2.4.0*
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
	if [ `use opengl` ]; then
		myconf="${myconf} BUILD_GLCANVAS=1"
	else
		myconf="${myconf} BUILD_GLCANVAS=0"
		patch -p1 < ${FILESDIR}/wxPython-2.3.3.1-noglcanvas.diff \
			|| die "patch failed"
	fi
	if [ `use gtk2` ]; then
		myconf="${myconf} WXPORT=gtk2"
	else
		myconf="${myconf} WXPORT=gtk"
	fi

	python setup.py ${myconf} build || die "build failed"
}

src_install() {
	#Other possible configuration variables are BUILD_OGL and BUILD_STC.
	#BUILD_OGL builds the Object Graphics Library extension module.
	#BUILD_STC builds the wxStyledTextCtrl (the Scintilla wrapper) extension module.
	#Both these variable are enabled by default.  To disable them set equal to zero
	#and add to myconf.
	local myconf=""
	if [ `use opengl` ]; then
		myconf="${myconf} BUILD_GLCANVAS=1"
	else
		myconf="${myconf} BUILD_GLCANVAS=0"
	fi
	if [ `use gtk2` ]; then
		myconf="${myconf} WXPORT=gtk2"
	else
		myconf="${myconf} WXPORT=gtk"
	fi

	python setup.py ${myconf} install --prefix=/usr --root=${D} || die
}
