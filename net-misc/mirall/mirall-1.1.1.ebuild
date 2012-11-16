# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mirall/mirall-1.1.1.ebuild,v 1.1 2012/11/16 20:16:04 johu Exp $

EAPI=4

LANG_DIR="translations"
PLOCALES="af ar ar_SA bg_BG ca cs_CZ da de el en eo es es_AR et_EE eu eu_ES fa fi fi_FI fr gl he hi hr hu_HU hy ia id id_ID it ja_JP ko lb lt_LT lv mk nb_NO nl nn_NO oc pl pl_PL pt_BR pt_PT ro ru ru_RU sk_SK sl sr sr@latin sv tr uk vi zh_CN zh_TW"
inherit cmake-utils l10n

DESCRIPTION="Synchronization of your folders with another computers"
HOMEPAGE="http://owncloud.org/"
SRC_URI="http://download.owncloud.com/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=net-misc/csync-0.60.0[sftp,samba,webdav]
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-test:4
"
DEPEND="${RDEPEND}"

src_prepare() {
	# Yay for fcked detection.
	export CSYNC_DIR="${EPREFIX}/usr/include/ocsync/"

	local lang
	for lang in ${PLOCALES} ; do
		if ! use linguas_${lang} ; then
			rm ${LANG_DIR}/${PN}_${lang}.ts
		fi
	done
}
