# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/matlab/matlab-2.2.3.ebuild,v 1.11 2006/01/26 15:49:52 mkennedy Exp $

inherit elisp

IUSE=""

DESCRIPTION="Major modes for MATLAB dot-m and dot-tlc files"
HOMEPAGE="http://www.mathworks.com/products/matlab/"
# the original home page
# ftp://ftp.mathworks.com/pub/contrib/emacs_add_ons but this has since
# moved to http://www.mathworks.com/access/pub/emacs_add_ons.zip
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc sparc x86"

DEPEND="virtual/emacs"

SITEFILE=50matlab-gentoo.el
