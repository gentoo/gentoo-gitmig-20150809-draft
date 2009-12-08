# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/slim-themes/slim-themes-1.2.3a-r4.ebuild,v 1.4 2009/12/08 19:23:58 nixnut Exp $

DESCRIPTION="SLiM (Simple Login Manager) themes pack"
HOMEPAGE="http://slim.berlios.de"
SRC_URI="mirror://berlios/slim/slim-1.2.3-themepack1a.tar.gz
	mirror://berlios/slim/slim-gentoo-simple.tar.bz2
	mirror://gentoo/slim-archlinux.tar.gz
	mirror://berlios/slim/slim-debian-moreblue.tar.bz2
	mirror://berlios/slim/slim-fingerprint.tar.gz
	mirror://berlios/slim/slim-flat.tar.gz
	mirror://berlios/slim/slim-lunar-0.4.tar.bz2
	mirror://berlios/slim/slim-previous.tar.gz
	mirror://berlios/slim/slim-rainbow.tar.gz
	mirror://berlios/slim/slim-rear-window.tar.gz
	mirror://berlios/slim/slim-scotland-road.tar.gz
	mirror://berlios/slim/slim-subway.tar.gz
	mirror://berlios/slim/slim-wave.tar.gz
	mirror://berlios/slim/slim-zenwalk.tar.gz
	mirror://berlios/slim/slim-archlinux-simple.tar.gz
	mirror://berlios/slim/slim-lake.tar.gz
	mirror://gentoo/slim-gentoo-1.0.tar.bz2
	http://www.xfce-look.org/CONTENT/content-files/48605-xfce-g-box-slim-0.1.tar.gz
	http://slim.berlios.de/themes/gentoo_10_blue.tar.bz2
	http://slim.berlios.de/themes/gentoo_10_purple.tar.bz2
	http://slim.berlios.de/themes/gentoo_10_dark.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND="x11-misc/slim"
DEPEND=""

RESTRICT="strip binchecks"

S="${WORKDIR}"

src_compile() {
	:
}

src_install() {
	for i in slim-archlinux capernoited flower2 mindlock lotus-{sage,midnight} \
		Zenwalk	isolated subway xfce-g-box gentoo; do
			rm ${i}/README
	done

	rm parallel-dimensions/{LICENSE*,COPY*} debian-moreblue/COPY* \
		lotus-{sage,midnight}/{LICENSE*,COPY*} xfce-g-box/COPYRIGHT.panel

	local themesdir="/usr/share/slim/themes"
	dodir ${themesdir}
	cp -R . "${D}"/${themesdir}
}
