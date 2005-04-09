# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/cw/cw-1.0.10.ebuild,v 1.2 2005/04/09 02:07:42 ka0ttic Exp $

DESCRIPTION="A non-intrusive real-time ANSI color wrapper for common unix-based commands"
HOMEPAGE="http://cwrapper.sourceforge.net/"
SRC_URI="mirror://sourceforge/cwrapper/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
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
	einfo "To enable color-wrapper, as your user, run:"
	einfo "  colorcfg [1|2|3]"
	einfo "to add relevant environment variables to your ~/.bash_profile"
	einfo "Run colorcfg without options to see what [1|2|3] means."
	einfo
	einfo "After sourcing your ~/.bash_profile, commands for which definitions"
	einfo "are provided should have colored output."
	einfo
	einfo "To enable/disable colored output, run: 'colors [on|off]'."
	echo
}
