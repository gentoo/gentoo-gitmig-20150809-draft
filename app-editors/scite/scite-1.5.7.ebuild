# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/scite/scite-1.5.7.ebuild,v 1.3 2004/03/25 07:31:05 mr_bones_ Exp $

MY_PV=$(echo ${PV} | sed 's:\.::g')

DESCRIPTION="A very powerful editor for programmers"
SRC_URI="mirror://sourceforge/scintilla/${PN}${MY_PV}.tgz"
HOMEPAGE="http://www.scintilla.org"

DEPEND="gtk2? ( >=x11-libs/gtk+-2 )
	!gtk2? ( =x11-libs/gtk+-1.2* )
	>=sys-apps/sed-4"

S=${WORKDIR}/${PN}/gtk

SLOT="0"
LICENSE="PYTHON"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="gtk2 gnome"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}/scintilla/gtk
	sed -i makefile \
		-e "s#^CXXFLAGS=#CXXFLAGS=${CXXFLAGS} #" \
		-e "s#^\(CXXFLAGS=.*\)-Os#\1#" \
		-e "s#^CC =\(.*\)#CC = ${CXX:-g++}#" \
		|| die "error patching makefile"

	cd ${S}
	sed -i makefile \
		-e 's#usr/local#usr#g' \
		-e 's#/gnome/apps/Applications#/applications#' \
		-e "s#^CXXFLAGS=#CXXFLAGS=${CXXFLAGS} #" \
		-e "s#^\(CXXFLAGS=.*\)-Os#\1#" \
		-e "s#^CC =\(.*\)#CC = ${CXX:-g++}#" \
		-e 's#${D}##' \
		|| die "error patching makefile"

}

src_compile() {
	local makeopts
	use gtk2 && makeopts="GTK2=1"
	#use debug && makeopts="${makeopts} DEBUG=1"

	make -C ../../scintilla/gtk ${makeopts}  || die "prep make failed"
	emake ${makeopts} || die "make failed"
}

src_install () {
	dodir /usr
	dodir /usr/bin
	dodir /usr/share
	dodir /usr/share/pixmaps
	dodir /usr/share/applications

	make prefix=${D}/usr install || die

	# we have to keep this because otherwise it'll break upgrading
	mv ${D}/usr/bin/SciTE ${D}/usr/bin/scite
	dosym /usr/bin/scite /usr/bin/SciTE

	# replace .desktop file with our own working version
	insinto /usr/share/applications
	rm -f ${D}/usr/share/applications/SciTE.desktop
	doins ${FILESDIR}/scite.desktop

	doman ../doc/scite.1
	dodoc ../License.txt ../README
}
