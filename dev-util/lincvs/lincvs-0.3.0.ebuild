# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/lincvs/lincvs-0.3.0.ebuild,v 1.2 2001/05/09 04:37:31 achim Exp $

S=${WORKDIR}/LinCVS-0.3
DESCRIPTION="A Graphical CVS Client"
SRC_URI="http://ppprs1.phy.tu-dresden.de/~trogisch/${PN}/download/${P}/${PN}-0.3-0-generic-src.tgz
	 http://ppprs1.phy.tu-dresden.de/~trogisch/${PN}/download/${P}/${PN}-0.3.patch-1.tgz"
HOMEPAGE="http://www.lincvs.de"

DEPEND="kde? ( >=kde-base/kdelibs-2.1.1 )
        >=x11-libs/qt-x11-2.2.2"
RDEPEND="$DEPEND
	 dev-util/cvs"

src_unpack () {

  unpack ${A}
  patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
  cd ${S}/src
  patch diffview.cpp ${WORKDIR}/LinCVS-patch/diffview.patch

}	

src_compile() {

    if [ "`use kde`" ] ; then
      sed "s:KDE2DIR:KDEDIR:g" Makefile.kde2 > Makefile
    fi
    cp Makefile Makefile.orig
    sed -e "s:-O2:${CFLAGS}:" Makefile.orig > Makefile

    make

}

src_install () {

    into /usr/X11R6
    dobin LinCVS tools/*.sh
    insinto /usr/X11R6/share/icons/lincvs
    doins res/*.xpm
    dodoc AUTHORS COPYING ChangeLog *.{txt,TXT}

}


