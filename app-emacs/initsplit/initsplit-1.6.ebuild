# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/initsplit/initsplit-1.6.ebuild,v 1.3 2005/06/29 17:50:30 mkennedy Exp $

inherit elisp

DESCRIPTION="Split customizations into different files"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki?InitSplit"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

SITEFILE=50initsplit-gentoo.el
