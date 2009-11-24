# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/matlab/matlab-3.1.0_pre20070306.ebuild,v 1.6 2009/11/24 20:59:48 fauli Exp $

inherit elisp

DESCRIPTION="Major modes for MATLAB dot-m and dot-tlc files"
HOMEPAGE="http://matlab-emacs.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

DEPEND="app-emacs/cedet"
RDEPEND="${DEPEND}"

SITEFILE=51${PN}-gentoo.el
DOCS="README INSTALL ChangeLog*"

S="${WORKDIR}/matlab-emacs"
