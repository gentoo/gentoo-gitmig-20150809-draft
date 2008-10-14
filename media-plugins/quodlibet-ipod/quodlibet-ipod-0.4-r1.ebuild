# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/quodlibet-ipod/quodlibet-ipod-0.4-r1.ebuild,v 1.1 2008/10/14 16:21:11 flameeyes Exp $

EAPI=2

inherit python eutils

DESCRIPTION="This is a plugin to copy songs to your iPod and browse/delete existing songs using libgpod."
HOMEPAGE="http://www.sacredchao.net/quodlibet/wiki/Plugins/iPod"
SRC_URI="mirror://gentoo/quodlibet-ipod-0.4.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=media-libs/libgpod-0.3.2-r1[python]
	>=media-sound/quodlibet-0.19.1"

PLUGIN_DEST="/usr/share/quodlibet/plugins/songsmenu"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-ipod-detect.patch
}

src_install() {
	cd "${WORKDIR}"

	insinto ${PLUGIN_DEST}
	doins ipod_base.py

	insinto ${PLUGIN_DEST}/ipod
	doins ipod/*
}

pkg_postinst() {
	python_mod_compile ${PLUGIN_DEST}/ipod_base.py
	python_mod_optimize ${PLUGIN_DEST}/ipod
}

pkg_postrm() {
	python_mod_cleanup ${PLUGIN_DEST}
}
