# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/matlab/matlab-2.2.3.ebuild,v 1.12 2007/10/27 10:44:23 opfer Exp $

inherit elisp

IUSE=""

DESCRIPTION="Major modes for MATLAB dot-m and dot-tlc files"
HOMEPAGE="http://matlab-emacs.sourceforge.net/"

SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc sparc x86"

SITEFILE=50${PN}-gentoo.el
