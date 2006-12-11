# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/cynthiune/cynthiune-0.9.5.ebuild,v 1.1 2006/12/11 18:45:44 grobian Exp $

inherit eutils gnustep

S=${WORKDIR}/${P/c/C}

DESCRIPTION="Free software and romantic music player for GNUstep."
HOMEPAGE="http://organact.mine.nu/~wolfgang/cynthiune"
SRC_URI="http://organact.mine.nu/~wolfgang/cynthiune/${P/c/C}.tar.gz"

IUSE="arts"

KEYWORDS="~ppc ~x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="${GS_DEPEND}
	>=media-libs/libid3tag-0.15.0b
	>=media-libs/libmad-0.15.1b
	media-libs/audiofile
	>=media-libs/libogg-1.1.2
	>=media-libs/libvorbis-1.0.1-r2
	~media-libs/libmodplug-0.7
	media-libs/flac
	media-libs/libmpcdec
	media-sound/esound
	arts? ( kde-base/arts )"
RDEPEND="${GS_RDEPEND}
	>=media-libs/libid3tag-0.15.0b
	>=media-libs/libmad-0.15.1b
	media-libs/audiofile
	>=media-libs/libogg-1.1.2
	>=media-libs/libvorbis-1.0.1-r2
	~media-libs/libmodplug-0.7
	media-libs/flac
	media-libs/libmpcdec
	media-sound/esound
	arts? ( kde-base/arts )"

egnustep_install_domain "Local"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}"/${P}-flac-1.1.3.patch
}

cynthiune_get_config() {
	local myconf=""
	# Gentoo doesn't have libavi (any more)
	myconf="${myconf} disable-windowsmedia=yes"
	use arts || myconf="${myconf} disable-arts=yes"

	echo ${myconf}
}

src_compile() {
	egnustep_env
	egnustep_make "$(cynthiune_get_config)" || die "make failed"
}

src_install() {
	egnustep_env
	egnustep_install "$(cynthiune_get_config)" || die
	if use doc ; then
		egnustep_env
		egnustep_doc || die
	fi
	egnustep_package_config
}
