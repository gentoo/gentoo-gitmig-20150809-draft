# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/tagtool/tagtool-0.9.ebuild,v 1.4 2004/09/03 15:28:12 dholm Exp $

inherit eutils

IUSE="oggvorbis mp3"

DESCRIPTION="Audio Tag Tool Ogg/Mp3 Tagger"
HOMEPAGE="http://pwp.netcabo.pt/paol/tagtool/"
SRC_URI="http://pwp.netcabo.pt/paol/tagtool/${P}.tar.gz
		mirror://gentoo/tagtool-0.9-configure.patch.tar.bz2"

DEPEND=">=x11-libs/gtk+-2.4.0-r1
	>=gnome-base/libglade-2.4.0
	mp3? ( >=media-libs/id3lib-3.8.3-r2 )
	oggvorbis? ( >=media-libs/libvorbis-1.0.1 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

src_compile() {
	cd ${S}

	local myconf
	myconf=""
	myconf="${myconf} $(use_enable mp3)"
	myconf="${myconf} $(use_enable oggvorbis vorbis)"

	#add some configure logic to prevent a dying ebuild
	if use !mp3 && use !oggvorbis
	then
		ewarn "Vorbis or mp3 must be selected."
		ewarn "Defaulting to mp3, please cancel this emerge"
		ewarn "if you do not want mp3 support."
		myconf="--enable-mp3"
	fi

	#fix the strange upstream configure logic
	epatch ${DISTDIR}/${P}-configure.patch.tar.bz2

	econf \
		${myconf} || die "econf failed"
	emake || die
}

src_install() {
	make install \
		DESTDIR=${D} \
		sysdir=${D}/usr/share/applets/Multimedia \
		GNOME_SYSCONFDIR=${D}/etc \
		|| die

	dodoc ChangeLog NEWS README TODO THANKS
}
