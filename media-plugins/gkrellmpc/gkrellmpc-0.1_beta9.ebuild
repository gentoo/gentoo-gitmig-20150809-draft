# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gkrellmpc/gkrellmpc-0.1_beta9.ebuild,v 1.7 2007/07/10 23:08:59 mr_bones_ Exp $

inherit gkrellm-plugin

DESCRIPTION="A gkrellm plugin to control the MPD (Music Player Daemon)"
HOMEPAGE="http://mpd.wikicities.com/wiki/Client:GKrellMPC"
SRC_URI="http://www.topfx.com/dist/${P}.tar.gz"
IUSE=""

RDEPEND="net-misc/curl"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"
