# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/easytag/easytag-0.31-r4.ebuild,v 1.1 2004/09/12 12:34:25 dsd Exp $

inherit eutils gnuconfig

IUSE="nls oggvorbis flac"

MY_P="${P}_gtk2.4_pre2"
DESCRIPTION="EasyTAG mp3/ogg ID3 tag editor"
HOMEPAGE="http://easytag.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

RDEPEND=">=media-libs/id3lib-3.8.2
	>=x11-libs/gtk+-2.4.1
	flac? ( >=media-libs/flac-1.1.0 >=media-libs/libvorbis-1.0 )
	oggvorbis? ( >=media-libs/libvorbis-1.0 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ppc64"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${MY_P}.tar.bz2
	cd ${S}
	use ppc64 && gnuconfig_update
}

src_compile() {
	local myconf

	econf \
		$(use_enable oggvorbis ogg) \
		$(use_enable nls) \
		$(use_enable flac) \
		${myconf} || die "econf failed"
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
	einfo "This version of EasyTAG is GTK+ 2.4 based only, with no GTK+ 1.x support"
	ewarn "GTK+ 2 support for this program is still experimental"
	ewarn "Please report bugs to http://bugs.gentoo.org"
}
