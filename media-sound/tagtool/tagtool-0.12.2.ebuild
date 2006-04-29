# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/tagtool/tagtool-0.12.2.ebuild,v 1.3 2006/04/29 09:49:04 blubb Exp $


DESCRIPTION="Audio Tag Tool Ogg/Mp3 Tagger"
HOMEPAGE="http://pwp.netcabo.pt/paol/tagtool/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

#-sparc: 0.10 doesn't browse files properly
KEYWORDS="amd64 ~ppc ~sparc ~x86"
IUSE="vorbis mp3"

DEPEND=">=x11-libs/gtk+-2.4.0-r1
	>=gnome-base/libglade-2.4.0
	mp3? ( >=media-libs/id3lib-3.8.3-r3 )
	vorbis? ( >=media-libs/libvorbis-1.0.1 )"

src_compile() {
	local myconf
	myconf=""

	# Stupid configure thinks --enable-{mp3,vorbis} disables it.
	# add some configure logic to prevent a dying ebuild
	if use !mp3 && use !vorbis
	then
		ewarn "Vorbis or mp3 must be selected."
		ewarn "Defaulting to mp3, please cancel this emerge"
		ewarn "if you do not want mp3 support."
		myconf="--disable-vorbis"
	else
		use mp3 || myconf="${myconf} --disable-mp3"
		use vorbis || myconf="${myconf} --disable-vorbis"
	fi

	econf ${myconf} || die "econf failed"
	emake || die "make failed"
}

src_install() {
	make install \
		DESTDIR=${D} \
		sysdir=${D}/usr/share/applets/Multimedia \
		GNOME_SYSCONFDIR=${D}/etc \
		|| die "make install failed"

	dodoc ChangeLog NEWS README TODO THANKS
}
