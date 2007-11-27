# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/vdrplugin-rebuild/vdrplugin-rebuild-0.2.ebuild,v 1.6 2007/11/27 10:40:52 zzam Exp $

DESCRIPTION="A utility to rebuild any plugins for vdr which you have installed."
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND="!>=media-tv/gentoo-vdr-scripts-0.4.2"

src_install() {
	newsbin "${FILESDIR}/${P%_rc*}" ${PN}
	keepdir /usr/share/vdr/vdrplugin-rebuild
}

pkg_postinst() {
	if has_version "<=media-tv/vdrplugin-rebuild-0.1"; then
		# populate new database
		"${ROOT}"/usr/sbin/vdrplugin-rebuild populate

		local OLD_DB="${ROOT}"/var/lib/vdrplugin-rebuild
		if [[ -d "${OLD_DB}" ]]; then
			elog "Removing old vdrplugindb."
			rm "${OLD_DB}"/vdrplugindb*
			rmdir "${OLD_DB}"
		fi
	fi
}
