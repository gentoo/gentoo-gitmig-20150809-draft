# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/lincvs/lincvs-0.3.0-r1.ebuild,v 1.4 2002/07/23 05:29:48 raker Exp $

S=${WORKDIR}/LinCVS-0.3
DESCRIPTION="A Graphical CVS Client"
SRC_URI="http://ppprs1.phy.tu-dresden.de/~trogisch/${PN}/download/${P}/${PN}-0.3-0-generic-src.tgz
	 http://ppprs1.phy.tu-dresden.de/~trogisch/${PN}/download/${P}/${PN}-0.3.patch-1.tgz"
HOMEPAGE="http://www.lincvs.de"
SLOT="0"
DEPEND="kde? ( =kde-base/kdelibs-2* ) =x11-libs/qt-2*"
RDEPEND="$DEPEND dev-util/cvs"
KEYWORDS="*"
LICENSE="GPL-2"

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
	into /usr
	dobin LinCVS tools/*.sh
	insinto /usr/share/icons/lincvs
	doins res/*.xpm
	dodoc AUTHORS COPYING ChangeLog 
	#This is required by the app - uncmopressed txt's
	cd ${D}/usr/share/doc
	ln -s ${P}-${PR} ${PN}
	cd ${PN}
	cp ${S}/*.{txt,TXT} .
}


