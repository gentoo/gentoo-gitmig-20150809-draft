# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/cw/cw-1.0.16.ebuild,v 1.1 2010/09/12 13:18:34 jlec Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="A non-intrusive real-time ANSI color wrapper for common unix-based commands"
HOMEPAGE="http://cwrapper.sourceforge.net/"
SRC_URI="mirror://sourceforge/cwrapper/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${PV}-ldflags.patch
	sed -i 's|\(CWLIB=\)/usr/local/lib/cw|\1/usr/libexec/cw|' bin/colorcfg || \
		die "sed failed"
	tc-export CC
}

#src_configure() {
#	econf \
#		CFLAGS="${CFLAGS}" \
#		LDFLAGS="${LDFLAGS}"
#}

src_compile() {
	emake \
		local || die "emake failed"
}

src_install() {
	insinto /usr/share/cw
	doins etc/* || die

	exeinto /usr/libexec/cw
	doexe def/* || die

	doman man/* || die
	dodoc CHANGES CONTRIB INSTALL README PLATFORM doc/README* || die

	dobin bin/{cw,cwu,colorcfg} || die
	# app-misc/color currently conflicts; hopefully 'colors' is safe
	newbin bin/color colors
}

pkg_postinst() {
	ebegin "Updating definition files"
	cwu /usr/libexec/cw /usr/bin/cw >/dev/null
	eend $?

	elog "To enable color-wrapper, as your user, run:"
	elog "  colorcfg [1|2|3]"
	elog "to add relevant environment variables to your ~/.bash_profile"
	elog "Run colorcfg without options to see what [1|2|3] means."
	elog
	elog "After sourcing your ~/.bash_profile, commands for which definitions"
	elog "are provided should have colored output."
	elog
	elog "To enable/disable colored output, run: 'colors [on|off]'."
}
