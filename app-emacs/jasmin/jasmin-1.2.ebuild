# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/jasmin/jasmin-1.2.ebuild,v 1.5 2004/11/01 11:12:38 usata Exp $

inherit elisp

DESCRIPTION="An Emacs major mode for editing Jasmin Java bytecode assembler files."
HOMEPAGE="http://www.neilvandyke.org/jasmin-emacs/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 s390 ~alpha ~ppc-macos"
IUSE=""

SITEFILE=50jasmin-gentoo.el
