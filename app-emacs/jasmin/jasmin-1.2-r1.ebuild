# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/jasmin/jasmin-1.2-r1.ebuild,v 1.3 2007/06/17 12:31:05 armin76 Exp $

inherit elisp

DESCRIPTION="An Emacs major mode for editing Jasmin Java bytecode assembler files"
HOMEPAGE="http://www.neilvandyke.org/jasmin-emacs/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~ppc-macos ~s390 x86"
IUSE=""

SITEFILE=60${PN}-gentoo.el
