# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/jasmin/jasmin-1.2.ebuild,v 1.3 2004/06/15 08:38:24 kloeri Exp $

inherit elisp

DESCRIPTION="An Emacs major mode for editing Jasmin Java bytecode assembler files."
HOMEPAGE="http://www.neilvandyke.org/jasmin-emacs/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 s390"
IUSE=""
DEPEND="virtual/emacs"

SITEFILE=50jasmin-gentoo.el
