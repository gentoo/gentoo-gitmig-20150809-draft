# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Chad Huneycutt <chad.huneycutt@acm.org>
# /home/cvsroot/gentoo-x86/skel.build,v 1.5 2001/07/24 22:30:35 lordjoe Exp

S=${WORKDIR}/${P}
DESCRIPTION="This is a sample skeleton ebuild file"
SRC_URI="http://www.ohse.de/uwe/releases/lrzsz-0.12.20.tar.gz"

#Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="http://www.ohse.de/uwe/software/lrzsz.html"

DEPEND=""

#run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	try ./configure --infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST}
	
	try emake
	#try make
}

src_install () {
	try make prefix=${D}/usr install
    #try make DESTDIR=${D} install

	dosym /usr/bin/lrb /usr/bin/rb
	dosym /usr/bin/lrx /usr/bin/rx
	dosym /usr/bin/lrz /usr/bin/rz
	dosym /usr/bin/lsb /usr/bin/sb
	dosym /usr/bin/lsx /usr/bin/sx
	dosym /usr/bin/lsz /usr/bin/sz

	dodoc ABOUT-NLS AUTHORS COMPATIBILITY COPYING ChangeLog NEWS README README.cvs README.gettext README.isdn4linux README.tests THANKS TODO
}

