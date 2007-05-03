# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ibuffer/ibuffer-2.6.1.ebuild,v 1.3 2007/05/03 18:54:09 ulm Exp $

inherit elisp

# Rumor has it this package will be part of FSF GNU Emacs soon...

DESCRIPTION="Operate on buffers like dired"
HOMEPAGE="http://www.shootybangbang.com/"
# taken from http://www.shootybangbang.com/software/ibuffer.el
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

SITEFILE=51${PN}-gentoo.el
