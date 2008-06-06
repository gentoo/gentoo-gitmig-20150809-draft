# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/mybashburn/mybashburn-1.0.2.ebuild,v 1.2 2008/06/06 22:10:06 drac Exp $

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
	mp3? ( media-sound/lame
		virtual/mpg123 )
	flac? ( media-libs/flac )
	vorbis? ( media-sound/vorbis-tools )
	normalize? ( media-sound/normalize )"

RESTRICT="test"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc CREDITS ChangeLog FAQ HOWTO README TODO
}
