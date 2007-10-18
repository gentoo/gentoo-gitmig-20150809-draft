# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/uboat/uboat-1.2.ebuild,v 1.13 2007/10/18 21:31:11 ulm Exp $

inherit elisp

DESCRIPTION="Generate u-boat-death messages, patterned after Iron Coffins"
HOMEPAGE="http://www.splode.com/~friedman/software/emacs-lisp/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

# public domain according to http://www.splode.com/~friedman/software/
LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el
