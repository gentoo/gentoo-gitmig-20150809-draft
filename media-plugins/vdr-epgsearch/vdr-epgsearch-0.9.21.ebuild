# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-epgsearch/vdr-epgsearch-0.9.21.ebuild,v 1.2 2007/07/10 23:08:59 mr_bones_ Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder epgsearch plugin"
HOMEPAGE="http://freenet-homepage.de/cwieninger/html/vdr-epg-search.html"
SRC_URI="http://people.freenet.de/cwieninger/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.45"

src_unpack() {
	vdr-plugin_src_unpack

	cd ${S}
	fix_vdr_libsi_include conflictcheck.c
}

src_install() {
	vdr-plugin_src_install
	diropts "-m755 -o vdr -g vdr"
	keepdir /etc/vdr/plugins/epgsearch

	cd ${S}
	emake install-doc MANDIR="${D}/usr/share/man"
	dodoc MANUAL
}

pkg_postinst() {
	vdr-plugin_pkg_postinst
	if has_version "<media-plugins/vdr-epgsearch-0.9.18"; then
		elog "Moving config-files to new location /etc/vdr/plugins/epgsearch"
		cd ${ROOT}/etc/vdr/plugins
		local f
		local moved=""
		for f in epgsearch*.* .epgsearch*; do
			[[ -e ${f} ]] || continue
			mv "${f}" "${ROOT}/etc/vdr/plugins/epgsearch"
			moved="${moved} ${f}"
		done
		elog "These files were moved:${moved}"
	fi
}
