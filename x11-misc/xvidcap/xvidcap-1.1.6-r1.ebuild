# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xvidcap/xvidcap-1.1.6-r1.ebuild,v 1.1 2007/06/26 16:22:33 drac Exp $

GCONF_DEBUG="no"

inherit autotools eutils gnome2

DESCRIPTION="Screen capture utility enabling you to create videos of your desktop for illustration or documentation purposes."
HOMEPAGE="http://xvidcap.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="mp3 theora"

RDEPEND=">=x11-libs/gtk+-2.6
	>=media-video/ffmpeg-0.4.9_p20070616
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
	epatch "${FILESDIR}"/${P}-ffmpeg.patch
	eautoreconf
}

src_compile() {
	econf --without-forced-embedded-ffmpeg \
		--includedir=/usr/include/ffmpeg \
		$(use_enable mp3 libmp3lame) \
		$(use_enable theora libtheora)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || "emake install failed."

	# Almost like bug #58322 but directory name changed.
	rm -rf "${D}"/usr/share/doc/${PN}
	dodoc AUTHORS ChangeLog README TODO.tasks
}
