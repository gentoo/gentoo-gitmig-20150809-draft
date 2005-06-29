# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/httpd/httpd-1.0.ebuild,v 1.3 2005/06/29 17:36:51 mkennedy Exp $

inherit elisp

DESCRIPTION="A HTTP server embedded in the Emacs"
HOMEPAGE="http://www.chez.com/emarsden/downloads/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~sparc x86 ~amd64"
IUSE=""

SITEFILE=50httpd-gentoo.el
