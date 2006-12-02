# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/fish/fish-1.21.8.ebuild,v 1.3 2006/12/02 01:47:39 antarus Exp $

DESCRIPTION="fish is the Friendly Interactive SHell"
HOMEPAGE="http://fishshell.org/"
SRC_URI="http://fishshell.org/files/${PV}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="X"
RDEPEND="sys-libs/ncurses
	sys-devel/bc
	www-client/htmlview
	X? ( x11-misc/xsel )"
DEPEND="${RDEPEND}
	app-doc/doxygen"

src_compile() {
	econf \
		docdir=/usr/share/doc/${PF} \
		--without-xsel \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install
}

pkg_postinst() {
	einfo
	einfo "If you want to use fish as your default shell, you need to add it"
	einfo "to /etc/shells. This is not recommended because fish doesn't install"
	einfo "to /bin."
	einfo
	ewarn "Many files moved to ${ROOT}usr/share/fish/completions from /etc/fish.d/."
	ewarn "Delete everything in ${ROOT}etc/fish.d/ except fish_interactive.fish."
	ewarn "Otherwise, fish won't notice updates to the installed files,"
	ewarn "because the ones in /etc will override the new ones in /usr."
	einfo
}
