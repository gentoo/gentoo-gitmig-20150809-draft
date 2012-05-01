# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/youtube-viewer/youtube-viewer-2.5.8_p20120415.ebuild,v 1.2 2012/05/01 23:55:08 hasufell Exp $

EAPI=4

DESCRIPTION="A command line utility for viewing youtube-videos in Mplayer"
HOMEPAGE="http://trizen.googlecode.com"
SRC_URI="mirror://github/hasufell/tinkerbox/${P}.xz
	http://dev.gentoo.org/~floppym/distfiles/${P}.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/libwww-perl
	dev-perl/XML-Fast
	media-video/mplayer[X,mp3,faad,x264]
	virtual/perl-Scalar-List-Utils"

S=${WORKDIR}

src_install() {
	newbin ${P} ${PN}
}
