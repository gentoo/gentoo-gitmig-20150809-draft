# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/qwerty/qwerty-1.1.ebuild,v 1.3 2004/06/01 14:09:05 vapier Exp $

inherit elisp

IUSE=""
DESCRIPTION="Switch between QWERTY and DVORAK without changing the console keymap."
HOMEPAGE="gnu.emacs.sources Message-ID: <NJ104.93Mar1125218@bootes.cus.cam.ac.uk>"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
DEPEND="virtual/emacs"

S="${WORKDIR}/${P}"

SITEFILE=50qwerty-gentoo.el
