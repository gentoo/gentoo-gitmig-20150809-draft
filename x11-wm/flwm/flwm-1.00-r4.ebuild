# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/flwm/flwm-1.00-r4.ebuild,v 1.12 2007/07/13 18:37:55 coldwind Exp $

inherit eutils flag-o-matic

DESCRIPTION="A lightweight window manager based on fltk"
HOMEPAGE="http://flwm.sourceforge.net"
SRC_URI="http://flwm.sourceforge.net/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc x86"
IUSE="opengl"

DEPEND="=x11-libs/fltk-1.1*
	opengl? ( virtual/opengl )"
RDEPEND="${DEPEND}"

	#Configuration of the appearance and behavior of flwm
	#must be done at compile time, i.e. there is
	#no .flwmrc file or interactive configuring while
	#running. To quote the man page, "gcc is your friend,"
	#so this type of configuration must be done at compile
	#time by editing the config.h file.  I can't see any
	#way to do this automagically so we'll echo a message
	#in pkg_postinst to tell the user to 'ebuild unpack'
	#and edit the config.h to their liking.

pkg_setup() {
	if ! built_with_use x11-libs/fltk noxft ; then
		eerror "${PN} requires x11-libs/fltk built without xft support."
		eerror "Please, reinstall x11-libs/fltk with USE=\"noxft\""
		eerror "before installing ${PN}."
		die "fltk without noxft"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-fltk1.1.patch"
}

src_compile() {
	use opengl && export X_EXTRA_LIBS=-lGL
	append-flags -I/usr/include/fltk-1.1
	append-ldflags -L/usr/lib/fltk-1.1

	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	doman flwm.1 || die
	dodoc README flwm_wmconfig || die
	dobin flwm || die
}

pkg_postinst() {
	elog "Customization of behaviour and appearance of"
	elog "flwm requires manually editing the config.h"
	elog "source file.  If you want to change the defaults,"
	elog "do the following:"
	elog ""
	elog "\tebuild ${P}.ebuild unpack"
	elog "\t${EDITOR} ${S}/config.h "
	elog "\tebuild ${P} compile install qmerge"
}
