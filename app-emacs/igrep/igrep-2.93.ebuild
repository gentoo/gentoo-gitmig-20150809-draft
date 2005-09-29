# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/igrep/igrep-2.93.ebuild,v 1.9 2005/09/29 05:31:04 josejx Exp $

inherit elisp

IUSE=""

DESCRIPTION='An improved interface to `grep` and `find`.'
HOMEPAGE="ftp://ftp.cis.ohio-state.edu/pub/emacs-lisp/archive/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

SITEFILE=50igrep-gentoo.el
