# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kenvy24gui/kenvy24gui-1.0a.ebuild,v 1.1 2008/03/19 18:55:19 flameeyes Exp $

inherit kde

DESCRIPTION="VIA Envy24 based sound card control utility for KDE"
HOMEPAGE="http://kenvy24.wiki.sourceforge.net/"
SRC_URI="mirror://sourceforge/kenvy24/${P/0a/0.a}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/${PN}"

RDEPEND=">=media-libs/alsa-lib-1.0.13"

need-kde 3.2
