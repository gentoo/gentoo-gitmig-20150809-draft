# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/markdown-mode/markdown-mode-1.8.1.ebuild,v 1.3 2011/09/22 00:15:17 tomka Exp $

EAPI=4

NEED_EMACS=19

EGIT_REPO_URI="http://jblevins.org/git/markdown-mode.git"
EGIT_COMMIT="v${PV}"

inherit elisp git-2

DESCRIPTION="major mode for editing Markdown-formatted text files"
HOMEPAGE="http://jblevins.org/projects/markdown-mode/"
# Cannot use this url because its hash differ about every five minutes
# SRC_URI="http://jblevins.org/git/markdown-mode.git/snapshot/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SITEFILE="50${PN}-gentoo.el"
