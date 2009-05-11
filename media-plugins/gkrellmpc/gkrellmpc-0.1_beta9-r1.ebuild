# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gkrellmpc/gkrellmpc-0.1_beta9-r1.ebuild,v 1.1 2009/05/11 22:08:53 ssuominen Exp $

EAPI=2
inherit eutils gkrellm-plugin toolchain-funcs

DESCRIPTION="A gkrellm plugin to control the MPD (Music Player Daemon)"
HOMEPAGE="http://mpd.wikicities.com/wiki/Client:GKrellMPC"
SRC_URI="http://www.topfx.com/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-misc/curl"

src_prepare() {
	epatch "${FILESDIR}"/${P}-mt.patch
}

src_compile() {
	tc-export CC
	emake || die "emake failed"
}
