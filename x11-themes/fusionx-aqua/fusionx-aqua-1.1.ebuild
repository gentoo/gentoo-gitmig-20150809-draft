# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/fusionx-aqua/fusionx-aqua-1.1.ebuild,v 1.20 2008/02/19 02:09:45 ingmar Exp $

MY_P="FusionX-Aqua-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="stylish \"Fusion X Aqua\" theme for KDE"
HOMEPAGE="http://www.kdelook.org/content/show.php?content=5296"
SRC_URI="http://www.kdelook.org/content/files/5296-${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="|| ( =kde-base/kwin-3.5* =kde-base/kdebase-3.5* )
	|| ( =kde-base/kdeartwork-kwin-styles-3.5* =kde-base/kdeartwork-3.5* )"
DEPEND=""

RESTRICT="binchecks strip"

src_install() {
	insinto /usr/share/apps/kstyle
	doins -r pixmaps themes || die "doins pixmap themes failed"

	insinto /usr/share/apps/kwin
	doins -r icewm-themes || die "doins icewm-themes failed"

	insinto /usr/share/apps/kdisplay
	doins -r color-schemes

	dodoc CREDITS README CHANGELOG
}

pkg_postinst() {
	elog "This theme is an IceWM pixmap theme for KDE."
	elog ""
	elog "To use this theme set the following options in the"
	elog "KDE Control Center:"
	elog " o Appearance & Themes"
	elog "	  - Style = \"fusionx-aqua\""
	elog "	  - Window Decorations = \"IceWM\""
	elog "		- Configuration [IceWM] = \"fusionX-aqua\""
	elog ""
	elog "To make the theme visible execute the following command"
	elog "from a shell or the KDE \"Run Command\" dialog:"
	elog "	  kinstalltheme"
}
