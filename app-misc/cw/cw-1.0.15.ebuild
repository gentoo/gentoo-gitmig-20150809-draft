# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/cw/cw-1.0.15.ebuild,v 1.6 2008/05/11 09:33:15 armin76 Exp $

DESCRIPTION="A non-intrusive real-time ANSI color wrapper for common unix-based commands"
HOMEPAGE="http://cwrapper.sourceforge.net/"
SRC_URI="mirror://sourceforge/cwrapper/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE=""

DEPEND=">=sys-apps/sed-4"
RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A} && cd ${S}
	sed -i 's|\(CWLIB=\)/usr/local/lib/cw|\1/usr/lib/cw|' bin/colorcfg || \
		die "sed failed"
}

src_compile() {
	econf || die "econf failed"
	emake local || die "emake failed"
}

src_install() {
	insinto /usr/share/cw
	doins etc/*

	exeinto /usr/lib/cw
	doexe def/*

	doman man/*
	dodoc CHANGES CONTRIB INSTALL README PLATFORM doc/README*

	cd ${S}/bin
	dobin cw cwu colorcfg
	# app-misc/color currently conflicts; hopefully 'colors' is safe
	newbin color colors
}

pkg_postinst() {
	ebegin "Updating definition files"
	cwu /usr/lib/cw /usr/bin/cw >/dev/null
	eend $?

	echo
	elog "To enable color-wrapper, as your user, run:"
	elog "  colorcfg [1|2|3]"
	elog "to add relevant environment variables to your ~/.bash_profile"
	elog "Run colorcfg without options to see what [1|2|3] means."
	elog
	elog "After sourcing your ~/.bash_profile, commands for which definitions"
	elog "are provided should have colored output."
	elog
	elog "To enable/disable colored output, run: 'colors [on|off]'."
	echo
}
