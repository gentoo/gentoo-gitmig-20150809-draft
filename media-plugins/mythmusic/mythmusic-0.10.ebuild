# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythmusic/mythmusic-0.10.ebuild,v 1.2 2003/08/07 04:03:26 vapier Exp $

inherit flag-o-matic

DESCRIPTION="Music player module for MythTV."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="opengl sdl X"

DEPEND=">=media-tv/mythtv-${PV}
	media-sound/mad
	media-sound/cdparanoia
	media-libs/libvorbis
	media-libs/libcdaudio
	>=media-libs/flac-1.0.4
	>=sys-apps/sed-4
	X? ( dev-libs/fftw )
	opengl? ( virtual/opengl dev-libs/fftw )
	sdl? ( >=media-libs/libsdl-1.2.5 )"

src_unpack() {
	unpack ${A}

	for i in `grep -lr "usr/local" "${S}"` ; do
		sed -e "s:/usr/local:/usr:" -i "${i}" || die "sed failed"
	done
}

src_compile() {
	local myconf
	myconf="${myconf} `use_enable X fftw`"
	myconf="${myconf} `use_enable opengl`"
	myconf="${myconf} `use_enable sdl`"

	cpu="`get-flag march`"
	if [ ! -z "${cpu}" ] ; then
		sed -e "s:pentiumpro:${cpu}:g" -i "${S}/settings.pro" || die "sed failed"
	fi

	qmake -o "${S}/Makefile" "${S}/${PN}.pro"

	econf ${myconf}

	emake || die "compile problem"
}

src_install() {
	make INSTALL_ROOT="${D}" install || die "make install failed"

	insinto "/usr/share/mythtv/database/${PN}"
	doins musicdb/*.sql

	dodoc AUTHORS COPYING README UPGRADING
	newdoc musicdb/README README.db
}

pkg_postinst() {
	einfo "If this is the first time you install MythMusic,"
	einfo "you need to add /usr/share/mythtv/database/${PN}/metadata.sql"
	einfo "to your MythTV database."
	einfo
	einfo "You might run 'mysql < /usr/share/mythtv/database/${PN}/metadata.sql'"
	einfo
	einfo "If you're upgrading from an older version and for more"
	einfo "setup and usage instructions, please refer to:"
	einfo "   /usr/share/doc/${PF}/README.gz"
	einfo "   /usr/share/doc/${PF}/UPGRADING.gz"
	ewarn "This part is important as there might be database changes"
	ewarn "which need to be performed or this package will not work"
	ewarn "properly."
}
