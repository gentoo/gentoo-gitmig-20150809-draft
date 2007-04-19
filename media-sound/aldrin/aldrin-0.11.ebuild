# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/aldrin/aldrin-0.11.ebuild,v 1.2 2007/04/19 13:37:00 hanno Exp $

DESCRIPTION="Aldrin is an extensible modular sequencer/tracker, compatible to Buzz"
HOMEPAGE="http://aldrin.sourceforge.net/"
SRC_URI="mirror://sourceforge/aldrin/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-python/wxpython
	media-libs/libsndfile
	media-libs/ladspa-sdk
	media-sound/jack-audio-connection-kit
	media-libs/alsa-lib
	media-libs/libzzub
	dev-python/pyzzub"

DEPEND="${RDEPEND}
	dev-util/scons"

S="${WORKDIR}/${P}"

src_compile() {
	scons PREFIX=/usr || die
}

src_install() {
	scons DESTDIR="${D}" install || die
	dodoc CREDITS.txt
}
