# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythweather/mythweather-0.12.ebuild,v 1.3 2004/01/15 18:05:22 max Exp $

inherit flag-o-matic

DESCRIPTION="Weather forcast module for MythTV."
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
	local cpu="`get-flag march || get-flag mcpu`"
	if [ ! -z "${cpu}" ] ; then
		sed -e "s:pentiumpro:${cpu}:g" -i "settings.pro" || die "sed failed"
	fi

	qmake -o "Makefile" "${PN}.pro"
	emake || die "compile problem"
}

src_install() {
	einstall INSTALL_ROOT="${D}"
	dodoc AUTHORS COPYING README
}
