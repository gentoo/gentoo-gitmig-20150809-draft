# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Taras Glek <taras.glek@home.com>
# $Header: /var/cvsroot/gentoo-x86/app-editors/scite/scite-1.4.1.ebuild,v 1.3 2002/07/25 20:25:49 kabau Exp $

S=${WORKDIR}/$PN/gtk
MY_PV=141
DESCRIPTION="A very powerful editor for programmers"
SRC_URI="http://www.scintilla.org/${PN}${MY_PV}.tgz" 
HOMEPAGE="http://www.scintilla.org"

DEPEND="=x11-libs/gtk+-1.2*
		gnome? ( gnome-base/gnome-core )"
RDEPEND="=x11-libs/gtk+-1.2*"

SLOT="0"
LICENSE="PYTHON"
KEYWORDS="x86"

src_compile() {

    make -C ../../scintilla/gtk || die
    sed -e 's#usr/local#usr#g' \
		-e 's#$(datadir)#${D}$(datadir)#g' \
		makefile > Makefile.good || die
    rm makefile
    mv Makefile.good makefile
    emake || die
	
}

src_install () {

    dodir /usr
    dodir /usr/bin
    dodir /usr/share
	use gnome && dodir /usr/share/gnome/apps/Applications
    make prefix=${D}/usr install || die
    mv ${D}/usr/bin/SciTE ${D}/usr/bin/scite
	
}

