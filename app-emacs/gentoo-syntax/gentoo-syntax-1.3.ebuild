# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/gentoo-syntax/gentoo-syntax-1.3.ebuild,v 1.1 2007/06/21 18:10:13 ulm Exp $

inherit elisp

MY_P=ebuild-mode-${PV}
DESCRIPTION="An Emacs mode for editing Portage .ebuild, .eclass and .eselect files"
HOMEPAGE="http://www.gentoo.org/proj/en/lisp/emacs/"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}/${MY_P}"
SITEFILE=50${PN}-gentoo.el
