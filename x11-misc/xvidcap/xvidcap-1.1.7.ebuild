# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xvidcap/xvidcap-1.1.7.ebuild,v 1.2 2009/03/11 22:43:18 aballier Exp $

GCONF_DEBUG="no"

inherit eutils autotools gnome2

MY_P=${P/_rc/rc}
DESCRIPTION="Screen capture utility to create videos of your desktop for documentation purposes"
HOMEPAGE="http://xvidcap.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="mp3 theora"

RDEPEND=">=x11-libs/gtk+-2.6
	gnome-base/libglade
	>=media-video/ffmpeg-0.4.9_p20080326
	mp3? ( media-sound/lame )
	theora? ( media-libs/libtheora )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	virtual/libintl
	app-text/scrollkeeper
	dev-perl/XML-Parser
	app-text/gnome-doc-utils"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-ffmpeg-headers.patch
	# bug 242680
	epatch "${FILESDIR}"/${P}-ffmpeg-trellis.patch
	epatch "${FILESDIR}"/${P}-avutil.patch
	eautoreconf
	# bug 242678
	intltoolize --force || die "intltoolize failed"
}

src_compile() {
	econf --without-forced-embedded-ffmpeg \
		$(use_enable mp3 libmp3lame) \
		$(use_enable theora libtheora)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."

	# Almost like bug #58322 but directory name changed.
	rm -rf "${D}"/usr/share/doc/${PN}
	dodoc AUTHORS ChangeLog README TODO.tasks

	# Optional. See also bug 232590.
	elog "For previewing the captured movie you should install media-video/mplayer"
}
