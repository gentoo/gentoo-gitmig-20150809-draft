# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythvideo/mythvideo-0.15.1.ebuild,v 1.3 2004/07/14 13:29:30 aliz Exp $

IUSE=""

inherit flag-o-matic

DESCRIPTION="Video player module for MythTV."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=sys-apps/sed-4
	dev-perl/libwww-perl
	dev-perl/HTML-Parser
	dev-perl/URI
	|| ( media-video/mplayer media-video/xine-ui )
	|| ( >=media-tv/mythtv-${PV}* >=media-tv/mythfrontend-${PV}* )"

src_unpack() {
	unpack ${A} && cd "${S}"

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

src_install () {
	einstall INSTALL_ROOT="${D}"
	dodoc COPYING README UPGRADING
}
