# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/easytag/easytag-0.31.ebuild,v 1.6 2004/08/10 21:37:04 dsd Exp $

inherit eutils

IUSE="nls oggvorbis flac gtk2"

DSD_PATCH=${P}-dsd1.patch.bz2
DESCRIPTION="EasyTAG mp3/ogg ID3 tag editor"
HOMEPAGE="http://easytag.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
	gtk2? http://www.reactivated.net/patches/${PN}/${PV}/${DSD_PATCH}"

RDEPEND=">=media-libs/id3lib-3.8.2
	gtk2? ( =x11-libs/gtk+-2.4* )
	!gtk2? ( =x11-libs/gtk+-1.2* )
	flac? ( >=media-libs/flac-1.1.0 >=media-libs/libvorbis-1.0_beta4 )
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 )"

DEPEND="${RDEPEND}
	gtk2? ( >=sys-devel/automake-1.7 >=sys-devel/autoconf-2.5 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc ~alpha ~hppa amd64"

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}

	if use gtk2; then
		epatch ${DISTDIR}/${DSD_PATCH}

		export WANT_AUTOMAKE=1.7
		export WANT_AUTOCONF=2.5
		ebegin "Remaking configure script (be patient)"
		autoreconf &>/dev/null
		eend $?
	fi
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
	if use gtk2; then
		einfo "You merged with the \"gtk2\" USE flag set"
		ewarn "GTK+ 2 support for this program is still experimental"
		ewarn "Please report bugs to http://bugs.gentoo.org"
	fi
}
