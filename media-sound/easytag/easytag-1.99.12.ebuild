# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/easytag/easytag-1.99.12.ebuild,v 1.2 2006/10/19 20:19:24 flameeyes Exp $

DESCRIPTION="EasyTAG mp3/ogg ID3 tag editor"
HOMEPAGE="http://easytag.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="nls vorbis flac aac mp3"

DEPEND=">=x11-libs/gtk+-2.4.1
	mp3? ( >=media-libs/id3lib-3.8.2 )
	flac? ( ~media-libs/flac-1.1.2 >=media-libs/libvorbis-1.0 )
	vorbis? ( >=media-libs/libvorbis-1.0 )
	aac? ( media-libs/libmp4v2 )"

src_compile() {
	econf \
		$(use_enable mp3) \
		$(use_enable vorbis ogg) \
		$(use_enable nls) \
		$(use_enable flac) \
		$(use_enable aac mp4) \
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
	einfo "This version of EasyTAG is GTK+ 2.4 based only, with no GTK+ 1.x support"
	einfo "Please use EasyTAG 1.0 if you are looking for the stable GTK+ 1.x version"
	ewarn "GTK+ 2 support for this program is still experimental"
	ewarn "Please report bugs to http://bugs.gentoo.org"
}
