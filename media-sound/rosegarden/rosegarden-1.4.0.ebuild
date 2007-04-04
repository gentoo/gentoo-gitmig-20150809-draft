# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rosegarden/rosegarden-1.4.0.ebuild,v 1.4 2007/04/04 14:23:38 armin76 Exp $

inherit kde eutils flag-o-matic

S="${WORKDIR}/${P}"

DESCRIPTION="MIDI and audio sequencer and notation editor."
HOMEPAGE="http://www.rosegardenmusic.com/"
SRC_URI="mirror://sourceforge/rosegarden/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc x86"
IUSE="lirc"

RDEPEND="media-libs/alsa-lib
	media-sound/jack-audio-connection-kit
	media-libs/ladspa-sdk
	>=media-libs/ladspa-cmt-1.14
	media-libs/liblrdf
	media-libs/dssi"
DEPEND="${RDEPEND}
	dev-util/scons"
need-kde 3.4

LANGS="ca cs cy de en_GB en es et fi fr it ja nl ru sv zh_CN"

src_compile() {
	[ -d "$QTDIR/etc/settings" ] && addwrite "$QTDIR/etc/settings"
	addpredict "$QTDIR/etc/settings"

	local myconf="kdeincludes=$(kde-config --prefix)/include prefix=${ROOT}/usr"
	use amd64 && myconf="${myconf} libsuffix=64"
	use lirc || myconf="${myconf} nolirc=1"

	scons configure ${myconf} || die "configure failed"
	scons ${MAKEOPTS} || die "scons failed"
}

src_install() {
	scons install DESTDIR="${D}" languages="$(echo $(echo "${LINGUAS} ${LANGS}" | fmt -w 1 | sort | uniq -d))"
	dodoc AUTHORS README TRANSLATORS
}
