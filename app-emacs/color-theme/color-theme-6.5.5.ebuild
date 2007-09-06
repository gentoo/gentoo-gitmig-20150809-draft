# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/color-theme/color-theme-6.5.5.ebuild,v 1.3 2007/09/06 14:06:03 ulm Exp $

inherit elisp eutils

IUSE=""

DESCRIPTION="Install color themes (includes many themes and allows you to share your own with the world)"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki.pl?ColorTheme"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"

SITEFILE="50${PN}-gentoo.el"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/6.5.5-easy-menu-gentoo.patch" || die
}
