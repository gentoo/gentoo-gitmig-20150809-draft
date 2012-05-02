# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gtk-youtube-viewer/gtk-youtube-viewer-2.0.4_p20120422.ebuild,v 1.1 2012/05/02 00:39:31 hasufell Exp $

EAPI=4

DESCRIPTION="Gtk2 variant of YouTube-Viewer"
HOMEPAGE="http://code.google.com/p/trizen/"
SRC_URI="http://dev.gentoo.org/~hasufell/distfiles/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/gtk2-perl
	dev-perl/libwww-perl
	dev-perl/XML-Fast
	media-video/mplayer[X,mp3,faad,x264]
	virtual/freedesktop-icon-theme
	virtual/perl-Scalar-List-Utils
	x11-libs/gdk-pixbuf:2[X,jpeg]"
