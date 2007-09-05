# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/konversation/konversation-1.0.1-r3.ebuild,v 1.3 2007/09/05 15:51:44 armin76 Exp $

LANGS="bg ca da de el en_GB es et fi fr hu it ja ka ko nl pt ru sr sr@Latn sv tr zh_TW
	ar cs gl he lt pa pt_BR ta"
LANGS_DOC="da es et it nl pt ru sv"

USE_KEG_PACKAGING=1

inherit kde

DESCRIPTION="A user friendly IRC Client for KDE3.x"
HOMEPAGE="http://konversation.kde.org/"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

need-kde 3

PATCHES="${FILESDIR}/${P}-crash.patch
		${FILESDIR}/${P}-konsolepanel.patch
		${FILESDIR}/${P}-media-script-vulnerability.patch"

pkg_postinst() {
	kde_pkg_postinst

	if ! has_version kde-base/konsole && ! has_version kde-base/kdebase; then
		echo
		elog "If you want to be able to use Konsole from inside ${PN}, please emerge either"
		elog "kde-base/konsole or kde-base/kdebase."
		echo
	fi
}
