# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/easytag/easytag-0.30.ebuild,v 1.4 2004/01/18 19:52:28 seemant Exp $

IUSE="nls oggvorbis"

S=${WORKDIR}/${P}
DESCRIPTION="EasyTAG mp3/ogg ID3 tag editor"
SRC_URI="mirror://sourceforge/easytag/${P}.tar.bz2"
HOMEPAGE="http://easytag.sourceforge.net/"

RDEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/id3lib-3.8.2
	media-libs/flac
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 )"

DEPEND=">=sys-apps/sed-4.0.5"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc ~alpha ~hppa"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}c-gtk2.patch
}

src_compile() {
	local myconf

	#use_enable breaks this
	use oggvorbis || myconf="${myconf} --disable-ogg"

	econf `use_enable nls` || die
	emake || die
}

src_install() {
	einstall \
		sysdir=${D}/usr/share/applets/Multimedia \
		GNOME_SYSCONFDIR=${D}/etc \
		|| die

	dodoc ChangeLog COPYING NEWS README TODO THANKS USERS-GUIDE
}
