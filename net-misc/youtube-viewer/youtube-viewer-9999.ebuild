# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/youtube-viewer/youtube-viewer-9999.ebuild,v 1.7 2012/08/21 16:35:23 mr_bones_ Exp $

EAPI=4

inherit perl-module git-2

DESCRIPTION="A command line utility for viewing youtube-videos in Mplayer"
HOMEPAGE="http://trizen.googlecode.com"
SRC_URI=""
EGIT_REPO_URI="git://github.com/trizen/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-perl/Data-Dump
	dev-perl/libwww-perl
	dev-perl/XML-Fast
	|| ( media-video/mplayer[X,network]
		media-video/mplayer2[X,network] )
	virtual/perl-File-Spec
	virtual/perl-Getopt-Long
	virtual/perl-Scalar-List-Utils
	virtual/perl-Term-ANSIColor"
DEPEND="virtual/perl-Module-Build"

EGIT_SOURCEDIR="${WORKDIR}"
S=${WORKDIR}/WWW-YoutubeViewer

SRC_TEST="do"

pkg_postinst() {
	perl-module_pkg_postinst
	einfo
	elog "optional dependencies:"
	elog "  dev-perl/TermReadKey (to get the terminal width size)"
	elog "  dev-perl/Term-ReadLine-Gnu (for a better STDIN support)"
	elog "  net-misc/gcap (for retrieving Youtube closed captions)"
	einfo
}
