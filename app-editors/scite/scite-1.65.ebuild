# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/scite/scite-1.65.ebuild,v 1.1 2005/08/04 17:15:11 pythonhead Exp $

inherit toolchain-funcs

MY_PV=${PV//./}
DESCRIPTION="A very powerful editor for programmers"
HOMEPAGE="http://www.scintilla.org"
SRC_URI="mirror://sourceforge/scintilla/${PN}${MY_PV}.tgz"

LICENSE="Scintilla"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86 ~amd64"
IUSE="gtk2 lua"

RDEPEND="gtk2? ( >=x11-libs/gtk+-2 )
	!gtk2? ( =x11-libs/gtk+-1.2* )
	lua? ( >=dev-lang/lua-5 )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S=${WORKDIR}/${PN}/gtk

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}/scintilla/gtk
	sed -i makefile \
		-e "s#^CXXFLAGS=#CXXFLAGS=${CXXFLAGS} #" \
		-e "s#^\(CXXFLAGS=.*\)-Os#\1#" \
		-e "s#^CC =\(.*\)#CC = $(tc-getCXX)#" \
		|| die "error patching makefile"

	cd ${S}
	sed -i makefile \
		-e 's#usr/local#usr#g' \
		-e 's#/gnome/apps/Applications#/applications#' \
		-e "s#^CXXFLAGS=#CXXFLAGS=${CXXFLAGS} #" \
		-e "s#^\(CXXFLAGS=.*\)-Os#\1#" \
		-e "s#^CC =\(.*\)#CC = $(tc-getCXX)#" \
		-e 's#${D}##' \
		|| die "error patching makefile"
}

src_compile() {
	local makeopts
	use gtk2 || makeopts="GTK1=1"
	#use debug && makeopts="${makeopts} DEBUG=1"

	make -C ../../scintilla/gtk ${makeopts}  || die "prep make failed"
	emake ${makeopts} || die "make failed"
}

src_install() {
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
	dodoc ../README
}
