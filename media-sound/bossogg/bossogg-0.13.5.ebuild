# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/bossogg/bossogg-0.13.5.ebuild,v 1.2 2004/04/08 08:09:35 eradicator Exp $

IUSE="oggvorbis mad"

DESCRIPTION="Bossogg Music Server"
HOMEPAGE="http://bossogg.wishy.org"
SRC_URI="mirror://sourceforge/bossogg/${P}.tar.gz"
RESTRICT="nomirror"

KEYWORDS="x86 ~ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-libs/libao-0.8.3
	oggvorbis? ( media-libs/libvorbis )
	mad? ( media-sound/mad media-libs/id3lib )"

RDEPEND="${DEPEND}
	 dev-python/pysqlite"

src_compile() {
	local myconf
	myconf=""

	use oggvorbis \
		|| myconf="${myconf} --disable-ogg  --disable-oggtest \
		   --disable-vorbistest"
	use mad || myconf="${myconf} --disable-mp3"

	econf ${myconf} || die "could not configure"

	emake -j1 || die "emake failed"
}

src_install() {
	# borks make DESTDIR=${D} install || die
	einstall || die
	dodoc README TODO INSTALL COPYING

	exeinto /etc/init.d; newexe ${FILESDIR}/bossogg.initd bossogg
}

pkg_postinst() {
	enewgroup bossogg
	enewuser bossogg -1 /bin/bash /var/bossogg bossogg -G audio

	if ! [ -d /var/bossogg ]; then
		mkdir /var/bossogg
		chown bossogg:bossogg /var/bossogg
	fi

	einfo "After running the /etc/init.d/bossogg service for the first"
	einfo "time, /var/bossogg/.bossogg/bossogg.conf will be created."
	einfo "Please edit this file and restart the service to setup."
	einfo "the server."
}
