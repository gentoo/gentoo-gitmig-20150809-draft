# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/easytag/easytag-1.0.ebuild,v 1.4 2004/12/04 17:58:55 slarti Exp $

inherit eutils gnuconfig

IUSE="nls oggvorbis flac"

DESCRIPTION="EasyTAG mp3/ogg ID3 tag editor"
HOMEPAGE="http://easytag.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

RDEPEND=">=media-libs/id3lib-3.8.2
	=x11-libs/gtk+-1.2*
	flac? ( >=media-libs/flac-1.1.0 >=media-libs/libvorbis-1.0 )
	oggvorbis? ( >=media-libs/libvorbis-1.0 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc ~alpha ~hppa amd64 ~ppc64"

src_unpack() {
	unpack ${A}
	cd ${S}
	use ppc64 && gnuconfig_update
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

	dodoc ChangeLog COPYING NEWS README TODO THANKS USERS-GUIDE
}

pkg_postinst() {
	einfo "This version of EasyTAG is GTK+ 1.2 based only. GTK+ 2.4 support is"
	einfo "available in the easytag-1.99.x releases (to become 2.0)."
}
