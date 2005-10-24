# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/dircolors/dircolors-1.0-r1.ebuild,v 1.8 2005/10/24 13:44:06 josejx Exp $

inherit elisp

IUSE=""

DESCRIPTION="Provide the same facility of ls --color inside Emacs"
HOMEPAGE="ftp://ftp.cis.ohio-state.edu/pub/emacs-lisp/archive/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ppc64 x86"

SITEFILE=50dircolors-gentoo.el
