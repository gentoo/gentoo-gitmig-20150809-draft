# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/transkode/transkode-0.6-r1.ebuild,v 1.2 2008/04/24 11:22:48 flameeyes Exp $

ARTS_REQUIRED="never"

inherit kde eutils

DESCRIPTION="KDE frontend for various audio transcoding tools"
HOMEPAGE="http://kde-apps.org/content/show.php?content=37669"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"

IUSE="amarok shorten wavpack"

RDEPEND="media-libs/taglib
	amarok? ( media-sound/amarok )"
DEPEND="${RDEPEND}"
RDEPEND="${RDEPEND}
	shorten? ( media-sound/shorten )
	wavpack? ( media-sound/wavpack )
	media-video/mplayer"

need-kde 3.5

PATCHES=(
	"${FILESDIR}/${P}-wavpack-options-fix.patch"
	"${FILESDIR}/${P}-wvunpack-options-fix.patch"
	"${FILESDIR}/${P}+gcc-4.3.patch"
	)

src_compile() {
	local myconf="$(use_enable amarok amarokscript)"

	kde_src_compile
}

src_install() {
	kde_src_install

	dodir /usr/share/applications/kde
	mv "${D}/usr/share/applnk/Utilities/${PN}.desktop" \
		"${D}/usr/share/applications/kde"

	echo "Categories=Qt;KDE;AudioVideo;" \
		>> "${D}/usr/share/applications/kde/${PN}.desktop"
}

pkg_postinst() {
	if use amarok; then
		elog "If you want to use TransKode to encode audio files on the fly"
		elog "when transferring music to a portable media device, remember"
		elog "to start the TransKode script through the Script Manager"
		elog "on the Tools menu."
	fi
}
