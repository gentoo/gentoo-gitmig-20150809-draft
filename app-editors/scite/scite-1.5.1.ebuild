# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/scite/scite-1.5.1.ebuild,v 1.2 2003/06/29 18:24:09 aliz Exp $

S=${WORKDIR}/$PN/gtk
MY_PV=151
DESCRIPTION="A very powerful editor for programmers"
SRC_URI="http://www.scintilla.org/${PN}${MY_PV}.tgz" 
HOMEPAGE="http://www.scintilla.org"

DEPEND="virtual/glibc
	=x11-libs/gtk+-1.2*"
RDEPEND=""

SLOT="0"
LICENSE="PYTHON"
KEYWORDS="x86 ~ppc ~sparc"

src_compile() {
	make -C ../../scintilla/gtk || die
	sed -e 's#usr/local#usr#g' -e 's#$(datadir)#${D}$(datadir)#g' \
		makefile > Makefile.good || die
	mv Makefile.good makefile
	sed -e 's#Exec=SciTE#Exec=scite#g' \
		-e 's#Type=Application#Type=Development#g' \
		SciTE.desktop > SciTE.desktop.good
	mv SciTE.desktop.good SciTE.desktop
	emake || die
}

src_install () {
	dodir /usr
	dodir /usr/bin
	dodir /usr/share
	dodir /usr/share/pixmaps
	dodir /usr/share/gnome/apps/Applications
	make prefix=${D}/usr install || die
	mv ${D}/usr/bin/SciTE ${D}/usr/bin/scite
	doman ../doc/scite.1
	dodoc ../License.txt ../readme

	if use gnome ;
	then
		# fix category (this is a developers tool)
		mv ${D}/usr/share/gnome/apps/Applications \
			${D}/usr/share/gnome/apps/Development
	else
		rm -rf ${D}/usr/share/gnome
	fi
}

