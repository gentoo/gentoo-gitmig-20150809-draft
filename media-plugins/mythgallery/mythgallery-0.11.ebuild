# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythgallery/mythgallery-0.11.ebuild,v 1.3 2004/01/15 18:04:20 max Exp $

inherit flag-o-matic

DESCRIPTION="Gallery and slideshow module for MythTV."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=sys-apps/sed-4
	|| ( >=media-tv/mythtv-${PV} >=media-tv/mythfrontend-${PV} )"

src_unpack() {
	unpack ${A}

	for i in `grep -lr "usr/local" "${S}"` ; do
		sed -e "s:/usr/local:/usr:" -i "${i}" || die "sed failed"
	done
}

src_compile() {
	cpu="`get-flag march`"
	if [ ! -z "${cpu}" ] ; then
		sed -e "s:pentiumpro:${cpu}:g" -i "${S}/settings.pro" || die "sed failed"
	fi

	qmake -o "${S}/Makefile" "${S}/${PN}.pro"

	emake || die "compile problem"
}

src_install() {
	einstall INSTALL_ROOT="${D}"

	insinto "/usr/share/mythtv/database/${PN}"
	doins database/*.sql

	dodoc COPYING README UPGRADING
}

pkg_postinst() {
	einfo "If this is the first time you install MythGallery,"
	einfo "you need to add /usr/share/mythtv/database/${PN}/gallery.sql"
	einfo "to your MythTV database."
	einfo
	einfo "You might run 'mysql < /usr/share/mythtv/database/${PN}/gallery.sql'"
	einfo
	einfo "If you're upgrading from an older version and for more"
	einfo "setup and usage instructions, please refer to:"
	einfo "   /usr/share/doc/${PF}/README.gz"
	einfo "   /usr/share/doc/${PF}/UPGRADING.gz"
	ewarn "This part is important as there might be database changes"
	ewarn "which need to be performed or this package will not work"
	ewarn "properly."
	echo
}
