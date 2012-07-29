# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-lcdfilter/eselect-lcdfilter-1.ebuild,v 1.1 2012/07/29 15:46:07 yngwin Exp $

EAPI=4
inherit vcs-snapshot

DESCRIPTION="Eselect module to choose Freetype LCD filtering settings"
HOMEPAGE="https://github.com/yngwin/eselect-lcdfilter"
SRC_URI="${HOMEPAGE}/tarball/v1 -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-admin/eselect"
DEPEND=""

src_install() {
	dodoc README.rst infinality-settings.sh

	insinto "/usr/share/eselect/modules"
	doins lcdfilter.eselect

	insinto "/usr/share/${PN}"
	doins -r env.d
}

pkg_postinst() {
	elog "Use eselect lcdfilter to select an lcdfiltering font style."
	elog "You can customize /usr/share/${PN}/env.d/custom"
	elog "with your own settings. See /usr/share/doc/${PVR}/infinality-settings.sh"
	elog "for an explanation and examples of the variables."
	elog "This module is supposed to be used in pair with eselect infinality."
}
