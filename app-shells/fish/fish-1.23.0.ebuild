# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/fish/fish-1.23.0.ebuild,v 1.3 2009/02/09 22:18:05 maekke Exp $

inherit base

DESCRIPTION="fish is the Friendly Interactive SHell"
HOMEPAGE="http://fishshell.org/"
SRC_URI="http://fishshell.org/files/${PV}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="X"
RDEPEND="sys-libs/ncurses
	sys-devel/bc
	www-client/htmlview
	X? ( x11-misc/xsel )"
DEPEND="${RDEPEND}
	app-doc/doxygen"

PATCHES=( "${FILESDIR}/${P}-glibc-2.8.patch" )

src_compile() {
	# Set things up for fish to be a default shell.
	# It has to be in /bin in case /usr is unavailable.
	# Also, all of its utilities have to be in /bin.
	econf \
		docdir=/usr/share/doc/${PF} \
		--without-xsel \
		--bindir=/bin \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install
}

pkg_postinst() {
	elog
	elog "To use ${PN} as your default shell, you need to add /bin/${PN}"
	elog "to /etc/shells."
	elog
	ewarn "Many files moved to ${ROOT}usr/share/fish/completions from /etc/fish.d/."
	ewarn "Delete everything in ${ROOT}etc/fish.d/ except fish_interactive.fish."
	ewarn "Otherwise, fish won't notice updates to the installed files,"
	ewarn "because the ones in /etc will override the new ones in /usr."
	echo
}
