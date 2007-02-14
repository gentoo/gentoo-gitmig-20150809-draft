# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/develock/develock-0.30.ebuild,v 1.1 2007/02/14 18:10:11 opfer Exp $

inherit elisp

IUSE=""

DESCRIPTION="An Emacs minor mode for highlighting broken formatting rules"
HOMEPAGE="http://www.jpl.org/ftp/pub/elisp/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~sparc ~amd64 ~ppc ~x86"

DEPEND=""

SITEFILE=50develock-gentoo.el