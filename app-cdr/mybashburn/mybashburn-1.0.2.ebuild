# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/mybashburn/mybashburn-1.0.2.ebuild,v 1.1 2007/11/02 04:56:22 beandog Exp $

DESCRIPTION="Command-line burning interface of data and music CDs and DVDs"
HOMEPAGE="http://mybashburn.sourceforge.net/"
SRC_URI="mirror://sourceforge/mybashburn/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="dvdr flac mp3 normalize vorbis"

DEPEND=""
RDEPEND="dev-util/dialog
	app-cdr/cdrdao
	app-cdr/cdrkit
	virtual/eject
	dvdr? ( app-cdr/dvd+rw-tools )
	mp3? ( media-sound/lame )
	flac? ( media-libs/flac )
	vorbis? ( media-sound/vorbis-tools )
	normalize? ( media-sound/normalize )"

RESTRICT="test"

src_install() {
	emake DESTDIR="${D}" install || die "einstall died"
	dodoc CREDITS ChangeLog FAQ HOWTO README TODO
}
