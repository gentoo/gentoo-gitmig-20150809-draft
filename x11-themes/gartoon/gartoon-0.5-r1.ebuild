# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gartoon/gartoon-0.5-r1.ebuild,v 1.2 2007/03/22 13:48:48 drac Exp $

DESCRIPTION="Gartoon SVG icon theme"
SRC_URI="http://zeus.qballcow.nl/icon/paket/${P}.tar.gz"
HOMEPAGE="http://zeus.qballcow.nl/?page_id=15"
LICENSE="GPL-2"

IUSE=""
KEYWORDS="~amd64 ~ppc sparc ~x86"
SLOT="0"

RESTRICT="nostrip"

S="${WORKDIR}/gartoon"
MY_DEST="/usr/share/icons/gartoon"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:\(^pixmap_path\) \(\".*\"$\):\1 \"${MY_DEST}/scalable/stock\":" \
		scalable/stock/iconrc
}

src_install() {
	cd "${S}"
	insinto ${MY_DEST}
	doins gartoon-pallete.svg index.theme scalable/stock/iconrc
	dodoc AUTHORS README scalable/stock/changelog_mula.txt

	for dir in apps devices emblems filesystems mimetypes stock; do
		cd ${S}/scalable/${dir}
		insinto ${MY_DEST}/scalable/${dir}
		for svg in *svg; do
			doins ${svg}
		done
	done

	cd "${S}"/scalable/apps
	dosym gnome-lockscreen.svg  ${MY_DEST}/scalable/apps/xfce-system-lock.svg
	dosym control-center2.svg  ${MY_DEST}/scalable/apps/xfce-system-settings.svg
	dosym gnome-logout.svg  ${MY_DEST}/scalable/apps/xfce-system-exit.svg
}
