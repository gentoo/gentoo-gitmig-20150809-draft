# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/analog/analog-1.9.99.ebuild,v 1.4 2008/06/14 23:20:53 ulm Exp $

inherit elisp

DESCRIPTION="Monitor lists of files or command output"
HOMEPAGE="http://mph-emacs-pkgs.alioth.debian.org/AnalogEl.html"
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el
