# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gaupol/gaupol-0.7.2.ebuild,v 1.3 2007/08/15 23:47:35 beandog Exp $

inherit distutils

DESCRIPTION="Gaupol is a subtitle editor for text-based subtitles."
HOMEPAGE="http://home.gna.org/gaupol/"
SRC_URI="http://download.gna.org/gaupol/0.7/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="spell"

RDEPEND=">=dev-python/pygtk-2.8
	dev-python/chardet
	spell? ( >=dev-python/pyenchant-1.1.3
		app-text/iso-codes )"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool"

src_install() {
	distutils_src_install
	dodoc AUTHORS ChangeLog TODO README NEWS
}

pkg_postinst() {
	elog "Please note that an external video player is required for"
	elog "preview. MPlayer or VLC is recommended."
	if use spell; then
		elog "Additionally, spell-checking requires a dictionary, any of"
		elog "Aspell/Pspell, Ispell, MySpell, Uspell, Hspell or AppleSpell."
	fi
}
