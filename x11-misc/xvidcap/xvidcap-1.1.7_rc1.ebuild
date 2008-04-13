# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xvidcap/xvidcap-1.1.7_rc1.ebuild,v 1.1 2008/04/13 23:27:54 yngwin Exp $

GCONF_DEBUG="no"

inherit eutils autotools gnome2

MY_P=${P/_rc/rc}
DESCRIPTION="Screen capture utility enabling you to create videos of your desktop for illustration or documentation purposes."
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

S=${WORKDIR}/${PN}-1.1.6

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-ffmpeg.patch
	epatch "${FILESDIR}"/${P}-new-ffmpeg-headers.patch
	eautoreconf
}

src_compile() {
	econf --without-forced-embedded-ffmpeg \
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
