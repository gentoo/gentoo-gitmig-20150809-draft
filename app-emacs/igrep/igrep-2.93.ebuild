# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/igrep/igrep-2.93.ebuild,v 1.8 2005/07/01 18:50:51 mkennedy Exp $

inherit elisp

IUSE=""

DESCRIPTION='An improved interface to `grep` and `find`.'
HOMEPAGE="ftp://ftp.cis.ohio-state.edu/pub/emacs-lisp/archive/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"

SITEFILE=50igrep-gentoo.el
