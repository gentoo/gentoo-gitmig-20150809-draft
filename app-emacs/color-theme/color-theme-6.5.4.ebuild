# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/color-theme/color-theme-6.5.4.ebuild,v 1.2 2004/03/04 04:58:17 jhuebel Exp $

inherit elisp

IUSE=""

DESCRIPTION="Install color themes (includes many themes and allows you to share you own with the world)"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki.pl?ColorTheme"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

SITEFILE="50${PN}-gentoo.el"
