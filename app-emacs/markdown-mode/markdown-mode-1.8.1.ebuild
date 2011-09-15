# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/markdown-mode/markdown-mode-1.8.1.ebuild,v 1.1 2011/09/15 16:44:15 naota Exp $

EAPI=4

NEED_EMACS=19

inherit elisp

DESCRIPTION="major mode for editing Markdown-formatted text files"
HOMEPAGE="http://jblevins.org/projects/markdown-mode/"
SRC_URI="http://jblevins.org/git/markdown-mode.git/snapshot/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

SITEFILE="50${PN}-gentoo.el"
