# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/cynthiune/cynthiune-0.9.5-r5.ebuild,v 1.1 2009/12/23 20:39:18 voyageur Exp $

inherit gnustep-2

S=${WORKDIR}/${P/c/C}

DESCRIPTION="Free software and romantic music player for GNUstep."
HOMEPAGE="http://organact.mine.nu/~wolfgang/cynthiune"
SRC_URI="http://organact.mine.nu/~wolfgang/cynthiune/${P/c/C}.tar.gz"

IUSE="flac mad modplug musepack timidity vorbis"

KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="GPL-2"
SLOT="0"

RDEPEND="media-libs/audiofile
	media-libs/taglib
	flac? ( media-libs/flac )
	mad? ( media-libs/libid3tag
		media-libs/libmad )
	musepack? ( >=media-sound/musepack-tools-444 )
	modplug? ( media-libs/libmodplug )
	timidity? ( media-sound/timidity++ )
	vorbis? ( >=media-libs/libogg-1.1.2
		>=media-libs/libvorbis-1.0.1-r2 )
	=media-libs/musicbrainz-2*"
DEPEND="${RDEPEND}
	mad? ( dev-util/pkgconfig )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-flac-1.1.3.patch
	epatch "${FILESDIR}"/${P}-set-macro.patch
	epatch "${FILESDIR}"/${P}-NSCellExtensions.patch
	epatch "${FILESDIR}"/${P}-NSMutableDictionary.patch
	epatch "${FILESDIR}"/${P}-gnustep-make-2.patch
	epatch "${FILESDIR}"/${P}-as-needed.patch
	epatch "${FILESDIR}"/${P}-libmpcdec.patch
}

cynthiune_get_config() {
	# Gentoo doesn't have libavi (any more)
	local myconf="disable-windowsmedia=yes disable-arts=yes disable-esound=yes"
	use flac || myconf="${myconf} disable-flac=yes disable-flactags=yes"
	use mad || myconf="${myconf} disable-mp3=yes disable-id3tag=yes"
	use modplug || myconf="${myconf} disable-mod=yes"
	use musepack || myconf="${myconf} disable-musepack=yes"
	use timidity || myconf="${myconf} disable-timidity=yes"
	use vorbis || myconf="${myconf} disable-ogg=yes disable-vorbistags=yes"

	echo ${myconf}
}

src_compile() {
	egnustep_env
	egnustep_make "$(cynthiune_get_config)" || die "make failed"
}

src_install() {
	egnustep_env
	egnustep_install "$(cynthiune_get_config)" || die
}
