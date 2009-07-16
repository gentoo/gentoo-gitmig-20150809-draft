# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/pymp/pymp-1.1.ebuild,v 1.1 2009/07/16 08:08:58 ssuominen Exp $

EAPI=2
inherit eutils multilib python

DESCRIPTION="a lean, flexible frontend to mplayer written in python"
HOMEPAGE="http://jdolan.dyndns.org/trac/wiki/Pymp"
SRC_URI="http://jdolan.dyndns.org/jaydolan/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-video/mplayer
	dev-python/pygtk
	>=dev-lang/python-2.5"
DEPEND="sys-apps/sed"

src_prepare() {
	sed -i -e "s:PREFIX/lib:/usr/$(get_libdir):" pymp || die "sed failed"
}

src_compile() { :; }

src_install() {
	dobin pymp || die "dobin failed"
	insinto /usr/$(get_libdir)/pymp
	doins *.py || die "doins failed"
	dodoc CHANGELOG README
	doicon pymp.png
	make_desktop_entry pymp Pymp pymp
}

pkg_postinst() {
	python_mod_optimize /usr/$(get_libdir)/pymp
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/pymp
}
