# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/vdrplugin-rebuild/vdrplugin-rebuild-0.2.ebuild,v 1.7 2008/06/15 08:29:59 zmedico Exp $

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

pkg_preinst() {
	has_version "<=${CATEGORY}/${PN}-0.1"
	previous_less_or_equal_to_0_1=$?
}

pkg_postinst() {
	if [[ $previous_less_or_equal_to_0_1 = 0 ]] ; then
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
