# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wxPython/wxPython-2.4.0.7.ebuild,v 1.1 2003/04/27 00:39:49 liquidx Exp $

IUSE="opengl gtk2"

MY_P="${P/-/Src-}"
S="${WORKDIR}/${MY_P}/${PN}"
DESCRIPTION="A blending of the wxWindows C++ class library with Python."
SRC_URI="mirror://sourceforge/wxpython/${MY_P}.tar.gz"
HOMEPAGE="http://www.wxpython.org/"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND=">=dev-lang/python-2.1
        =x11-libs/wxGTK-2.4.0*
        gtk2? ( >=x11-libs/gtk+-2.0 >=dev-libs/glib-2.0 ) : ( =x11-libs/gtk+-1.2* =dev-libs/glib-1.2* )
        opengl? ( >=dev-python/PyOpenGL-2.0.0.44 )"

pkg_setup() {
	# xfree should not install these, remove until the fixed
	# xfree is in main use.
	rm -f /usr/X11R6/include/{zconf.h,zlib.h}
    
    # make sure if you want gtk2, you have wxGTK with gtk2, and vice versa
    if [ -n "`use gtk2`" ]; then
    	if [ ! -f "/usr/bin/wxgtk2u-2.4-config" ]; then
        	eerror "You need x11-libs/wxGTK compiled with GTK+2 support."
            eerror "Either emerge wxGTK with 'gtk2' in your USE flags or"
            eerror "emerge wxPython without 'gtk2' in your USE flags."
            die "wxGTK needs to be compiled with gtk2"
        fi
    else
    	if [ ! -f "/usr/bin/wxgtk-2.4-config" ]; then
        	eerror "You need x11-libs/wxGTK compiled with GTK+1."
            eerror "Either emerge wxGTK without 'gtk2' in your USE flags or"
            eerror "emerge wxPython with 'gtk2' in your USE flags."
            die "wxGTK needs to be compiled without gtk2"
        fi
   fi
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
