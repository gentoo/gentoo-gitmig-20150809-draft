# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Chad Huneycutt <chad.huneycutt@acm.org>
# Notes:
#  1. first ebuild
#  2. I was unsuccessful getting the xaw version to run correctly (it will segfault
#     when the server starts the game
#
# /home/cvsroot/gentoo-x86/skel.build,v 1.5 2001/07/24 22:30:35 lordjoe Exp

S=${WORKDIR}/${P}
DESCRIPTION="Freeciv is a multiplayer strategy game (Civilization Clone)"
SRC_URI="ftp://ftp.freeciv.org/freeciv/stable/${P}.tar.bz2"
HOMEPAGE="http://www.freeciv.org"

# when compiling with xaw support, it doesn't work, so I am commenting out for now

DEPEND="virtual/x11 gtk? ( >=x11-libs/gtk+-1.2.1 >=media-libs/imlib-1.9.2 ) xaw3d? ( x11-base/xfree x11-libs/Xaw3d )" 

RDEPEND="${DEPEND}"


src_compile() {
	# standard options
	OPTIONS="--infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr/X11R6 --host=${CHOST}"

	if [ -z "`use gtk`" && -z "`use xaw3d`" ]; then
		einfo "This package requires either gtk or xaw3d USE keywords to be defined"
		exit 1
	fi

	if [ "`use gtk`" ]; then
		OPTIONS="${OPTIONS} --enable-client=gtk"
	fi

	if [ "`use xaw3d`" ]; then
		OPTIONS="${OPTIONS} --enable-client=xaw3d"
	fi

	if [ "`use nls`" ]; then
		OPTIONS="${OPTIONS} --with-included-gettext"
	else
		OPTIONS="${OPTIONS} --disable-nls"
	fi

	try ./configure ${OPTIONS}

	try emake
	#try make
}

src_install () {
	try make prefix=${D}/usr/X11R6 install
	if [ -z "`use gtk`" ]; then
		/bin/install -D -m 644 ${S}/data/Freeciv ${D}/usr/X11R6/lib/X11/app-defaults/Freeciv
	fi
	dodoc ABOUT-NLS AUTHORS BUGS ChangeLog HOWTOPLAY INSTALL NEWS PEOPLE README README.AI README.graphics README.rulesets TODO freeciv_hackers_guide.txt
}
