# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mute/mute-0.1.1.ebuild,v 1.1 2006/10/14 23:26:08 hanno Exp $

DESCRIPTION="Mute is an extensible modular sequencer/tracker, compatible to Buzz"
HOMEPAGE="http://trac.zeitherrschaft.org/zzub/"
SRC_URI="http://files.zeitherrschaft.org/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-python/wxpython
	media-libs/libsndfile
	dev-python/ctypes
	media-libs/ladspa-sdk
	media-sound/jack-audio-connection-kit
	media-libs/alsa-lib"

DEPEND="${RDEPEND}
	dev-util/scons"

S="${WORKDIR}/${P}"

src_compile() {
	scons PREFIX=/usr || die
}

src_install() {
	scons DESTDIR=${D} install || die
	dodoc CREDITS.txt
}
