# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/filladapt/filladapt-2.12.ebuild,v 1.2 2004/09/03 00:54:45 dholm Exp $

inherit elisp

DESCRIPTION="Filladapt enhances the behavior of Emacs' fill functions"
HOMEPAGE="http://www.wonderworks.com/"
SRC_URI="mirror://gentoo/${P}.el.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE=""

SITEFILE="50filladapt-gentoo.el"
SIMPLE_ELISP="t"
