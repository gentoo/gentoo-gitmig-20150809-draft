# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythdvd/mythdvd-0.15.ebuild,v 1.3 2004/09/21 05:07:20 cardoe Exp $

inherit flag-o-matic

DESCRIPTION="DVD player module for MythTV."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="transcode"

DEPEND=">=sys-apps/sed-4
	>=media-plugins/mythvideo-${PV}*
	media-libs/libdvdread
	transcode? ( media-video/transcode )
	|| ( media-video/mplayer media-video/xine-ui media-video/ogle )
	|| ( >=media-tv/mythtv-${PV} >=media-tv/mythfrontend-${PV} )"

src_unpack() {
	unpack ${A} && cd "${S}"

	for i in `grep -lr "usr/local" "${S}"` ; do
		sed -e "s:/usr/local:/usr:g" -i "${i}" || die "sed failed"
	done
}

src_compile() {
	local myconf
	myconf="--enable-vcd"
	myconf="${myconf} `use_enable transcode`"

	local cpu="`get-flag march || get-flag mcpu`"
	if [ "${cpu}" ] ; then
		sed -e "s:pentiumpro:${cpu}:g" -i "settings.pro" || die "sed failed"
	fi

	qmake -o "Makefile" "${PN}.pro"

	econf ${myconf} || die "econf failed"
	emake || die "compile problem"
}

src_install () {
	einstall INSTALL_ROOT="${D}"
	dodoc AUTHORS COPYING README README-database UPGRADING
}
