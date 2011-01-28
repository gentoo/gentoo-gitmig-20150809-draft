# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-admin/vdr-admin-0.8.0.ebuild,v 1.3 2011/01/28 17:21:00 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin

DESCRIPTION="VDR plugin: Admin OSD - This is not! the webadmin program called vdradmin."
HOMEPAGE="http://htpc-forum.de"
SRC_URI="mirror://vdrfiles/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.37"
RDEPEND="${DEPEND}"

S=${WORKDIR}/admin-${PV}

src_prepare() {
	vdr-plugin_src_prepare

	sed -i "s:/etc/vdr/plugins/admin:/usr/share/vdr/admin/bin:" gentoo/admin.conf
	sed -i "s:/etc/conf.d/vdr.admin.cfg:/usr/lib/vdr/rcscript/plugin-admin.sh:" gentoo/{runvdr,*.sh}
}

src_install() {
	vdr-plugin_src_install

	insinto /etc/vdr/plugins/admin
	doins gentoo/admin.conf

	exeinto /usr/share/vdr/admin/bin
	doexe gentoo/{runvdr,*.sh}

	dodoc gentoo/vdr
}

pkg_postinst() {
	vdr-plugin_pkg_postinst

	ewarn
	ewarn "This plugin is not changed to support gentoo-vdr-scripts."
	ewarn "So it may not work without large config changes"
	ewarn
	ewarn "There are more config Parameter than default are in /etc/conf.d/vdr"
	ewarn "Find examples in /usr/share/doc/${PF}"
}
