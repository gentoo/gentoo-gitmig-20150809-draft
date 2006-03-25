# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/cynthiune/cynthiune-0.9.4.ebuild,v 1.6 2006/03/25 16:51:46 grobian Exp $

inherit gnustep

S=${WORKDIR}/${P/c/C}

DESCRIPTION="Free software and romantic music player for GNUstep."
# 25 Mar 2006: upstream appears to be dead!
HOMEPAGE="http://organact.mine.nu/~wolfgang/cynthiune"
SRC_URI="http://organact.mine.nu/~wolfgang/cynthiune/${P/c/C}.tar.gz"

IUSE="esd flac mikmod vorbis"

KEYWORDS="~ppc ~x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="${GS_DEPEND}
	>=media-libs/libid3tag-0.15.0b
	>=media-libs/libmad-0.15.1b
	vorbis? ( >=media-libs/libogg-1.1.2
	    >=media-libs/libvorbis-1.0.1-r2 )
	mikmod? ( ~media-libs/libmodplug-0.7 )
	flac? ( >=media-libs/flac-1.1.0-r2 )
	esd? ( media-sound/esound )"
RDEPEND="${GS_RDEPEND}
	>=media-libs/libid3tag-0.15.0b
	>=media-libs/libmad-0.15.1b
	vorbis? ( >=media-libs/libogg-1.1.2
	    >=media-libs/libvorbis-1.0.1-r2 )
	mikmod? ( ~media-libs/libmodplug-0.7 )
	flac? ( >=media-libs/flac-1.1.0-r2 )
	esd? ( media-sound/esound )"

egnustep_install_domain "Local"

