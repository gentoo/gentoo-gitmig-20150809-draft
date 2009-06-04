# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sonata/sonata-1.6.2-r1.ebuild,v 1.3 2009/06/04 21:14:34 tcunha Exp $

EAPI=2
inherit distutils eutils

DESCRIPTION="an elegant GTK+ music client for the Music Player Daemon (MPD)."
HOMEPAGE="http://sonata.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 sparc x86"
IUSE="dbus lyrics taglib +trayicon"

RDEPEND=">=virtual/python-2.5
	>=dev-python/pygtk-2.12
	>=x11-libs/gtk+-2:2[jpeg]
	>=dev-python/python-mpd-0.2.1
	dbus? ( dev-python/dbus-python )
	lyrics? ( dev-python/zsi )
	taglib? ( >=dev-python/tagpy-0.93 )
	trayicon? ( dev-python/egg-python )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="CHANGELOG README TODO TRANSLATORS"

src_prepare() {
	epatch "${FILESDIR}"/${P}-keep_icons_constant.patch
}

src_install() {
	distutils_src_install
	rm -rf "${D}"/usr/share/sonata
}
