# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/jam-mode/jam-mode-0.1.ebuild,v 1.9 2007/07/04 05:41:23 ulm Exp $

inherit elisp

DESCRIPTION="An Emacs major mode for editing Jam files"
HOMEPAGE="http://www.tenfoot.uklinux.net/emacs/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 x86"
IUSE=""

SITEFILE=70${PN}-gentoo.el
