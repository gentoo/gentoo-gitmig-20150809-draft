# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/crontab-mode/crontab-mode-1.18.ebuild,v 1.3 2005/07/01 18:14:57 mkennedy Exp $

inherit elisp

IUSE=""

DESCRIPTION="Mode for editing crontab files"
HOMEPAGE="http://www.mahalito.net/~harley/elisp/"
SRC_URI="mirror://gentoo/${P}.el.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"

SITEFILE=50crontab-mode-gentoo.el
SIMPLE_ELISP=t
