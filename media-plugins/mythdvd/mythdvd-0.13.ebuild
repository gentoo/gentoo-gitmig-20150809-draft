# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythdvd/mythdvd-0.13.ebuild,v 1.2 2004/01/15 18:04:10 max Exp $

inherit flag-o-matic

DESCRIPTION="DVD player module for MythTV."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="alsa lirc transcode"

DEPEND="media-libs/libdvdread
	>=sys-apps/sed-4
	>=media-plugins/mythvideo-${PV}
	transcode? ( media-video/transcode )
	|| ( media-video/mplayer media-video/xine-ui media-video/ogle )
	|| ( >=media-tv/mythtv-${PV} >=media-tv/mythfrontend-${PV} )"

src_unpack() {
	unpack ${A}

	for i in `grep -lr "usr/local" "${S}"` ; do
		sed -e "s:/usr/local:/usr:g" -i "${i}" || die "sed failed"
	done
}

src_compile() {
	local myconf="--enable-vcd"
	myconf="${myconf} `use_enable transcode`"

	local cpu="`get-flag march || get-flag mcpu`"
	if [ "${cpu}" ] ; then
		sed -e "s:pentiumpro:${cpu}:g" -i "settings.pro" || die "sed failed"
	fi

	qmake -o "Makefile" "${PN}.pro"

	if [ "`use alsa`" ] ; then
		echo "CONFIG += using_alsa" >> settings.pro
		echo "EXTRA_LIBS += -lasound" >> settings.pro
	fi
	if [ "`use lirc`" ] ; then
		sed -e "s:#CONFIG += using_lirc:CONFIG += using_lirc:" \
			-e "s:#EXTRA_LIBS += -llirc_client:EXTRA_LIBS += -llirc_client:" \
			-i "settings.pro" || die "enable lirc sed failed"
	fi

	econf ${myconf}
	emake || die "compile problem"
}

src_install () {
	einstall INSTALL_ROOT="${D}"

	insinto "/usr/share/mythtv/database/${PN}"
	doins dvddb/*.sql

	dodoc AUTHORS COPYING README UPGRADING
	newdoc dvddb/README README.db
}

pkg_postinst() {
	einfo "If this is the first time you install MythDVD,"
	einfo "you need to add /usr/share/mythtv/database/${PN}/metadata.sql"
	einfo "to your MythTV database."
	einfo
	einfo "You might run 'mysql < /usr/share/mythtv/database/${PN}/metadata.sql'"
	einfo
	einfo "If you're upgrading from an older version and for more"
	einfo "setup and usage instructions, please refer to:"
	einfo "   /usr/share/doc/${PF}/README.gz"
	einfo "   /usr/share/doc/${PF}/README.db.gz"
	einfo "   /usr/share/doc/${PF}/UPGRADING.gz"
	ewarn "This part is important as there might be database changes"
	ewarn "which need to be performed or this package will not work"
	ewarn "properly."
	echo
}
