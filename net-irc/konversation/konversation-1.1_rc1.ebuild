# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/konversation/konversation-1.1_rc1.ebuild,v 1.1 2008/07/15 17:21:44 carlo Exp $

ARTS_REQUIRED="never"
USE_KEG_PACKAGING=1

inherit kde

MY_P="${P/_/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A user friendly IRC Client for KDE3.x"
HOMEPAGE="http://konversation.kde.org/"
SRC_URI="mirror://berlios/konversation/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

need-kde 3.5

LANGS="bg ca da de el es et fr gl he hu it ka ko pt sv"
LANGS_DOC="da es et it pt sv"

PATCHES="${FILESDIR}/konversation-1.1-desktop-entry-fix.diff"

pkg_postinst() {
	kde_pkg_postinst

	if ! has_version kde-base/konsole && ! has_version kde-base/kdebase; then
		echo
		elog "If you want to be able to use Konsole from inside ${PN}, please emerge either"
		elog "kde-base/konsole:3.5 or kde-base/kdebase:3.5."
		echo
	fi
}
