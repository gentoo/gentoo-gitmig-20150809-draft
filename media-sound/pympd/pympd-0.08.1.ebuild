# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pympd/pympd-0.08.1.ebuild,v 1.1 2007/05/26 21:23:27 ticho Exp $

inherit eutils toolchain-funcs python

DESCRIPTION="a Rhythmbox-like PyGTK+ client for Music Player Daemon"
HOMEPAGE="http://sourceforge.net/projects/pympd"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
IUSE=""

RDEPEND=">=virtual/python-2.4
	>=dev-python/pygtk-2.6
	x11-themes/gnome-icon-theme"

pkg_setup() {
	if ! built_with_use '=x11-libs/gtk+-2*' jpeg; then
		echo
		ewarn "If you want album cover art displayed in pympd,"
		ewarn "you must build gtk+-2.x with \"jpeg\" USE flag."
		echo
		ebeep 3
	fi
}

src_compile() {
	# Honor CFLAGS in make.conf
	export BUILDFLAGS="${CFLAGS}"
	sed -i -e 's:CFLAGS =:CFLAGS = ${BUILDFLAGS}:' src/modules/tray/Makefile
	emake CC="$(tc-getCC)" PREFIX="/usr" DESTDIR="${D}" || die "emake failed."
}

src_install() {
	# Fix for 'src//glade/../pympd.svg': No such file or directory
	sed -i -e 's:\..\/py:/usr/share/pympd/py:g' src/glade/pympd.glade

	emake PREFIX="/usr" DESTDIR="${D}" install || die "emake install failed."
	dodoc README
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/lib/python${PYVER}/site-packages/pympd
}

pkg_postrm() {
	python_version
	python_mod_cleanup
}
