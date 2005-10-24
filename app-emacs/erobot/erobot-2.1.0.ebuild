# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/erobot/erobot-2.1.0.ebuild,v 1.8 2005/10/24 14:26:25 josejx Exp $

inherit elisp

IUSE=""

DESCRIPTION='Battle-bots for Emacs!'
HOMEPAGE="ftp://ftp.cis.ohio-state.edu/pub/emacs-lisp/archive/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

SITEFILE=50erobot-gentoo.el
