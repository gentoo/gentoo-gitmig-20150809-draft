# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-extrecmenu/vdr-extrecmenu-1.2_pre1-r1.ebuild,v 1.1 2009/10/06 17:12:08 zzam Exp $

EAPI="2"

inherit vdr-plugin eutils

MY_P="${PN}-${PV/_pre/-test}"

S=${WORKDIR}/${PN#vdr-}-1.2

DVDARCHIVE="dvdarchive-2.3-beta.sh"

DESCRIPTION="Video Disk Recorder - Extended recordings menu Plugin"
HOMEPAGE="http://martins-kabuff.de/extrecmenu.html"
SRC_URI="http://martins-kabuff.de/download/${MY_P}.tgz
	mirror://gentoo/${DVDARCHIVE}.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-gcc43.patch"
	epatch "${FILESDIR}/${P}-gcc44.patch"

	cd "${WORKDIR}"
	epatch "${FILESDIR}/${DVDARCHIVE%.sh}-configfile.patch"

	cd "${S}"
	if grep -q fskProtection /usr/include/vdr/timers.h; then
		einfo "Enabling parentalrating option"
		sed -i "s:#WITHPINPLUGIN:WITHPINPLUGIN:" Makefile
	fi

	vdr-plugin_src_prepare
}

src_install() {
	vdr-plugin_src_install

	cd "${WORKDIR}"
	newbin ${DVDARCHIVE} dvdarchive.sh

	insinto /etc/vdr
	doins "${FILESDIR}"/dvdarchive.conf
}
