# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythmusic/mythmusic-0.12.ebuild,v 1.3 2004/01/15 18:04:45 max Exp $

inherit flag-o-matic

DESCRIPTION="Music player module for MythTV."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="opengl sdl X"

DEPEND=">=media-sound/cdparanoia-3.9.8
	>=media-libs/libmad-0.14.2b
	>=media-libs/libid3tag-0.14.2b
	>=media-libs/libvorbis-1.0
	>=media-libs/libcdaudio-0.99.6
	>=media-libs/flac-1.1.0
	>=sys-apps/sed-4
	X? ( =dev-libs/fftw-2* )
	opengl? ( virtual/opengl =dev-libs/fftw-2* )
	sdl? ( >=media-libs/libsdl-1.2.5 )
	|| ( >=media-tv/mythtv-${PV} >=media-tv/mythfrontend-${PV} )"

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

	# Fix bug 31952
	replace-flags mcpu=pentium4 mcpu=pentium3
	replace-flags march=pentium4 march=pentium3
	local cpu="`get-flag march || get-flag mcpu`"
	if [ "${cpu}" ] ; then
		sed -e "s:pentiumpro:${cpu}:g" -i "settings.pro" || die "sed failed"
	fi

	qmake -o "Makefile" "${PN}.pro"

	econf ${myconf}
	emake || die "compile problem"
}

src_install() {
	einstall INSTALL_ROOT="${D}"

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
