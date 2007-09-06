# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/color-theme/color-theme-6.5.4-r1.ebuild,v 1.5 2007/09/06 14:06:03 ulm Exp $

inherit elisp eutils

IUSE=""

DESCRIPTION="Install color themes (includes many themes and allows you to share your own with the world)"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki.pl?ColorTheme"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"

SITEFILE="50${PN}-gentoo.el"

src_unpack() {
	unpack ${A}
	local emacs_version=$(emacs --version |head -n 1 |cut -f3-3 -d' ')
	case $emacs_version	 in
		21*)
			# No patching required
			;;
		22*)
			epatch ${FILESDIR}/${PV}-easy-menu-gentoo.patch || die
			;;
		*)
			ewarn "Your version of Emacs (${emacs_version}) is not supported by this port."
			ewarn "You may have problems with color-theme.el"
			;;
	esac
}
