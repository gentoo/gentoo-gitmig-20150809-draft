# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/scite/scite-2.25.ebuild,v 1.2 2011/06/08 18:41:24 maekke Exp $

EAPI="1"

inherit toolchain-funcs eutils

MY_PV=${PV//./}
DESCRIPTION="A very powerful editor for programmers"
HOMEPAGE="http://www.scintilla.org/SciTE.html"
SRC_URI="mirror://sourceforge/scintilla/${PN}${MY_PV}.tgz"

LICENSE="Scintilla"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86 ~x86-fbsd"
IUSE="lua"

RDEPEND="x11-libs/gtk+:2
	lua? ( >=dev-lang/lua-5 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-apps/sed-4"

S="${WORKDIR}/${PN}/gtk"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}/scintilla/gtk"
	sed -i makefile \
		-e "s#^CXXFLAGS=#CXXFLAGS=${CXXFLAGS} #" \
		-e "s#^\(CXXFLAGS=.*\)-Os#\1#" \
		-e "s#^CC =\(.*\)#CC = $(tc-getCXX)#" \
		-e "s#-Os##" \
		|| die "error patching makefile"

	cd "${WORKDIR}/scite/gtk"
	sed -i makefile \
		-e "s#-rdynamic#-rdynamic ${LDFLAGS}#" \
		|| die "error patching makefile"

	cd "${S}"
	sed -i makefile \
		-e 's#usr/local#usr#g' \
		-e 's#/gnome/apps/Applications#/applications#' \
		-e "s#^CXXFLAGS=#CXXFLAGS=${CXXFLAGS} #" \
		-e "s#^\(CXXFLAGS=.*\)-Os#\1#" \
		-e "s#^CC =\(.*\)#CC = $(tc-getCXX)#" \
		-e 's#${D}##' \
		-e 's#-g root#-g 0#' \
		-e "s#-Os##" \
		|| die "error patching makefile"
	cd "${WORKDIR}"
	epatch "${FILESDIR}/${PN}-2.12-install.patch"
	epatch "${FILESDIR}/${PN}-2.12-no-lua.patch"
}

src_compile() {
	make -C ../../scintilla/gtk || die "prep make failed"
	if use lua; then
		emake || die "make failed"
	else
		emake NO_LUA=1 || die "make failed"
	fi
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/{pixmaps,applications}

	make prefix="${D}/usr" install || die

	# we have to keep this because otherwise it'll break upgrading
	mv "${D}/usr/bin/SciTE" "${D}/usr/bin/scite"
	dosym /usr/bin/scite /usr/bin/SciTE

	# replace .desktop file with our own working version
	insinto /usr/share/applications
	rm -f "${D}/usr/share/applications/SciTE.desktop"
	doins "${FILESDIR}/scite.desktop"

	doman ../doc/scite.1
	dodoc ../README
}
