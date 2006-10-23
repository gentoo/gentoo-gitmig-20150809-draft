# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvdrip/dvdrip-0.98.1.ebuild,v 1.5 2006/10/23 05:42:46 beandog Exp $

inherit eutils flag-o-matic perl-module

DESCRIPTION="Dvd::rip is a graphical frontend for transcode"
HOMEPAGE="http://www.exit1.org/dvdrip/"
SRC_URI="http://www.exit1.org/${PN}/dist/${P}.tar.gz"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 sparc ~x86"
IUSE="fping hal mplayer ogg subtitles vcd vorbis xine xvid"

DEPEND=">=dev-perl/Event-ExecFlow-0.62
	>=dev-perl/Event-RPC-0.89
	dev-perl/gtk2-perl
	>=dev-perl/gtk2-ex-formfactory-0.65
	>=dev-perl/libintl-perl-1.16
	media-gfx/imagemagick
	media-video/transcode"
RDEPEND="${DEPEND}
	fping? ( >=net-analyzer/fping-2.2 )
	hal? ( >=sys-apps/hal-0.5 )
	mplayer? ( media-video/mplayer )
	ogg? ( media-sound/ogmtools )
	subtitles? ( media-video/subtitleripper )
	vcd? ( >=media-video/mjpegtools-1.6.0 )
	vorbis? ( media-sound/vorbis-tools )
	xine? ( media-video/xine-ui )
	xvid? ( media-video/xvid4conf )
	>=media-video/lsdvd-0.15"

pkg_setup() {
	if ! built_with_use media-video/transcode dvdread; then
		eerror "Please re-emerge media-video/transcode with the dvdread"
		eerror "USE flag."
	fi
	if built_with_use media-video/transcode extrafilters; then
		eerror "Please re-emerge media-video/transcode without the"
		eerror "extrafilters USE flag."
	fi
	if ! built_with_use media-video/transcode dvdread || \
		built_with_use media-video/transcode extrafilters; then
		die "Fix media-video/transcode USE flags and re-emerge."
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	filter-flags "-ftracer"
	sed -i -e 's:cc :$(CC) :' src/Makefile || die "sed failed"
}

src_install() {
	newicon lib/Video/DVDRip/icon.xpm dvdrip.xpm
	make_desktop_entry dvdrip dvd::rip dvdrip.xpm AudioVideo
	DOCS="Changes Changes.0.46 Credits README TODO"

	perl-module_src_install
}
