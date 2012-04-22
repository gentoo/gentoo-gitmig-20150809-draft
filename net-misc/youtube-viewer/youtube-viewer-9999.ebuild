# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/youtube-viewer/youtube-viewer-9999.ebuild,v 1.1 2012/04/22 03:08:17 floppym Exp $

EAPI=4

inherit git-2

DESCRIPTION="A command line utility for viewing youtube-videos in Mplayer"
HOMEPAGE="http://trizen.googlecode.com"
SRC_URI=""
EGIT_REPO_URI="git://github.com/trizen/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/URI
	dev-perl/XML-Fast
	virtual/perl-Scalar-List-Utils"

src_install() {
	dobin ${PN}
}
