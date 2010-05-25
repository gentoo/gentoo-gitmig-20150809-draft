# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gaupol/gaupol-0.15.1.ebuild,v 1.2 2010/05/25 21:46:28 pacho Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"

inherit distutils fdo-mime gnome2-utils versionator

MAJOR_MINOR_VERSION="$(get_version_component_range 1-2)"

DESCRIPTION="Gaupol is a subtitle editor for text-based subtitles."
HOMEPAGE="http://home.gna.org/gaupol"
SRC_URI="http://download.gna.org/${PN}/${MAJOR_MINOR_VERSION}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="spell"

RDEPEND="dev-python/chardet
	>=dev-python/pygtk-2.12
	spell? ( >=dev-python/pyenchant-1.1.3
		app-text/iso-codes )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool"
RESTRICT_PYTHON_ABIS="3.*"

DOCS="AUTHORS ChangeLog CREDITS NEWS TODO README"

src_compile() {
	addpredict /root/.gconf
	addpredict /root/.gconfd
	distutils_src_compile
}

pkg_postinst() {
	distutils_pkg_postinst
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
	elog "Previewing support needs MPlayer or VLC."

	if use spell; then
		elog "Additionally, spell-checking requires a dictionary, any of"
		elog "Aspell/Pspell, Ispell, MySpell, Uspell, Hspell or AppleSpell."
	fi
}

pkg_postrm() {
	distutils_pkg_postrm
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
