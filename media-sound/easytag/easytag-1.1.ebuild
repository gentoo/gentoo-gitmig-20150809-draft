# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/easytag/easytag-1.1.ebuild,v 1.7 2005/06/21 05:51:09 tester Exp $

inherit eutils gnuconfig

DESCRIPTION="EasyTAG mp3/ogg ID3 tag editor"
HOMEPAGE="http://easytag.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ppc ppc64 sparc x86"
IUSE="nls oggvorbis flac"

RDEPEND=">=media-libs/id3lib-3.8.2
	=x11-libs/gtk+-1.2*
	flac? ( >=media-libs/flac-1.1.0 >=media-libs/libvorbis-1.0 )
	oggvorbis? ( >=media-libs/libvorbis-1.0 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	gnuconfig_update
}

src_compile() {
	econf \
		$(use_enable oggvorbis ogg) \
		$(use_enable nls) \
		$(use_enable flac) \
		|| die "econf failed"
	emake || die
}

src_install() {
	einstall \
		sysdir=${D}/usr/share/applets/Multimedia \
		GNOME_SYSCONFDIR=${D}/etc \
		|| die

	dodoc ChangeLog NEWS README TODO THANKS USERS-GUIDE
}

pkg_postinst() {
	einfo "This version of EasyTAG is GTK+ 1.2 based only. GTK+ 2.4 support is"
	einfo "available in the easytag-1.99.x releases (to become 2.0)."
}
