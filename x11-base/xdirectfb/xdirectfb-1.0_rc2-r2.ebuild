# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-base/xdirectfb/xdirectfb-1.0_rc2-r2.ebuild,v 1.1 2002/08/30 05:51:03 seemant Exp $

MY_PN="XDirectFB"
MY_PV=${PV/_/-}
MY_P=${MY_PN}-${MY_PV}
MY_V=X4299.20020827
S=${WORKDIR}/xc
X=${WORKDIR}/${MY_P}
DESCRIPTION="XDirectFB is a rootless XServer on top of DirectFB"

SRC_URI="http://www.ibiblio.org/gentoo/gentoo-sources/${MY_V}-1.tar.bz2
	http://www.ibiblio.org/gentoo/gentoo-sources/${MY_V}-2.tar.bz2
	http://www.ibiblio.org/gentoo/gentoo-sources/${MY_V}-3.tar.bz2
	 http://www.ibiblio.org/gentoo/gentoo-sources/truetype.tar.gz
	 http://www.directfb.org/download/${MY_PN}/${MY_P}.tar.gz"

HOMEPAGE="http://www.directfb.org"
LICENSE="X11"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

PROVIDE="virtual/x11"

DEPEND=">=sys-libs/ncurses-5.1
	>=sys-libs/zlib-1.1.3-r2
	sys-devel/flex
	sys-devel/perl
	dev-libs/DirectFB"
	
src_unpack () {

	unpack ${A}

	cd ${X}
	cp xc-directfb.diff ${S} 
	cp -a programs/Xserver/hw/directfb ${S}/programs/Xserver/hw
	cp ${X}/config/cf/directfb.cf ${S}/config/cf
	cp ${FILESDIR}/host.def ${S}/config/cf/
	
	cd ${S}
	patch -p0 < xc-directfb.diff || die

}

src_compile() {

	emake World || die
}

src_install() {

#	make install DESTDIR=${D}

	exeinto /usr/X11R6/bin
	doexe ${S}/programs/Xserver/XDirectFB 
	doexe ${FILESDIR}/startxdfb 

	mv ${S}/programs/Xserver/hw/directfb/XDirectFB._man ./XDirectFB.1x
	insinto /usr/X11R6/man/man1
	doins ${S}/XDirectFB.1x
	dodir /etc/skel
	dodir /etc/X11/xinit
	cp ${FILESDIR}/.dfbserverrc ${D}/etc/skel
	cp ${FILESDIR}/dfbserverrc ${D}/etc/X11/xinit
	
	dohtml ${S}/programs/Xserver/hw/directfb/XDirectFB.1x.html
	
	cd ${X}
	dodoc AUTHORS ChangeLog INSTALL README TODO
	
}

pkg_postinst() {

	chmod 4711 /usr/X11R6/bin/XDirectFB
	chmod 755 /usr/X11R6/bin/startxdfb

	echo
	echo '#######################################################'
	echo '#                                                     #'
	echo '#     To start XDirectFB use startxdfb utility.       #'
	echo '#     For example startxdfb -- -enableRoot			#'
	echo '#     Use -enableRoot if you have issues with menus   #'
	echo '#     not working in fluxbox or blackbox, etc.        #'
	echo '#                                                     #'
	echo '#     To set a background in XDirectFB create a       #'
	echo '#     file called directfbrc in /etc                  #'
	echo '#     (system wide setting) or .directfbrc            #'
	echo '#     in $HOME. XDirectFB will also just use your     #'
	echo '#     Window Managers background.                     #'
	echo '#                                                     #'
	echo '#     XDirectFB needs ~/.dfbserverrc or               #'
	echo '#     /etc/X11/xinit/dfbserverrc by default so please #'
	echo '#     edit these to you likeing.                      #'
	echo '#     cp /etc/skel/.dfbserverrc $HOME                 #'
	echo '#     Please take a look at this file and edit it,    #' 
	echo '#     you can add a options like -enableRoot, etc to  #'
	echo '#     it.  Though XDirectFB should just start with    #'
	echo '#     startxdfb                                       #'
	echo '#                                                     #'
	echo '#######################################################'
	echo
}
