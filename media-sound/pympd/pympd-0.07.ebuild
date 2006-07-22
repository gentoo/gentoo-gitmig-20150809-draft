# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pympd/pympd-0.07.ebuild,v 1.1 2006/07/22 16:05:33 ticho Exp $

inherit toolchain-funcs python

DESCRIPTION="a Rhythmbox-like PyGTK+ client for Music Player Daemon"
HOMEPAGE="http://sourceforge.net/projects/pympd"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

RDEPEND=">=virtual/python-2.4
	>=dev-python/pygtk-2.6"

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
