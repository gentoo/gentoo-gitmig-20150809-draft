# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/uboat/uboat-1.2.ebuild,v 1.11 2007/07/03 07:57:49 ulm Exp $

inherit elisp

DESCRIPTION="Generate u-boat-death messages, patterned after Iron Coffins"
HOMEPAGE="ftp://ftp.splode.com/pub/users/friedman/emacs-lisp/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el
