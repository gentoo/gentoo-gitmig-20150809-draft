# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ebuild-mode/ebuild-mode-1.1.ebuild,v 1.1 2006/11/25 19:53:46 mkennedy Exp $

inherit elisp

DESCRIPTION="An Emacs mode for editing Portage .ebuild, .eclass and .eselect files."
HOMEPAGE="http://bugs.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

SITEFILE=50ebuild-mode-gentoo.el
