# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pete@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/AfterStep/AfterStep-1.8.8.ebuild,v 1.2 2001/02/20 23:24:49 pete Exp $

#P=
A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="a window manager based on the NeXTStep interface"
SRC_URI="ftp://ftp.afterstep.org/stable/${A}"
HOMEPAGE="http://www.afterstep.org/"

DEPEND=">=x11-base/xfree-4.0
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.0.5"

RDEPEND=">=x11-base/xfree-4.0
	 >=media-libs/jpeg-6b
	 >=media-libs/libpng-1.0.5
	 >=media-sound/sox-12.17.1"


src_compile() {
    try ./configure --prefix=/usr/X11R6 --host=${CHOST} \
	--with-helpcommand=\""xterm -e man"\" \
	--disable-availability \
	--disable-staticlibs
    try make
}

src_install () {
    try make DESTDIR=${D} install
    rm -f ${D}/usr/X11R6/bin/sessreg
    
    dodoc COPYRIGHT ChangeLog NEW README README.HPUX
    dodoc README.RedHat README.SOLARIS TEAM UPGRADE
    
    cd ${S}/TODO ; docinto TODO
    dodoc BUGLIST.1st BUGLIST.l8r TODO-WinList active.desk.gz
    dodoc autoconf.patch.gz classic.afterstep.gz classic.wharf.gz
    dodoc fvwm.startondeskNpage.patch.gz gnome.html.gz
    
    cd ${S}/TODO/1.0_to_1.5 ; docinto TODO/1.0_to_1.5
    dodoc look.script step2files.pl whatsnew
    
    cd ${S}/TODO/unreleased ; docinto TODO/unreleased
    dodoc AfterStep-1.5beta3-stack-tabbing.diff.gz
    dodoc beta3-stack-tabiing.patch.gz
    
    cd ${S}/TODO/unstable ; docinto TODO/unstable
    dodoc as-icon+title.patch.gz as-icon+title.readme
    
    cd ${S}/doc/code ; docinto code
    dodoc Error_codes Optimizing Patch asetroot.format config_issues.html parser_devel_guide.html
    
    cd ${S}/doc/languages ; docinto languages
    dodoc README.cz README.de README.dk README.es README.fi README.fr
    dodoc README.gr README.id README.it README.jp README.nl README.no
    dodoc README.pl README.ro README.ru.koi8 README.se README.tw README.yu
    
    cd ${S}/doc/licences ; docinto licences
    dodoc COPYING COPYING.LDP COPYING.LIB
}
