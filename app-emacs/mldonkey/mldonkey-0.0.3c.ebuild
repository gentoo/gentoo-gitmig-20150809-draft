# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mldonkey/mldonkey-0.0.3c.ebuild,v 1.1 2004/04/20 06:40:37 mkennedy Exp $

inherit elisp

DESCRIPTION="mldonkey.el is an Emacs Lisp interface to the MLDonkey core"
HOMEPAGE="http://www.physik.fu-berlin.de/~dhansen/mldonkey/"
SRC_URI="http://www.physik.fu-berlin.de/%7Edhansen/mldonkey/files/mldonkey-el-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/emacs"
S=${WORKDIR}/mldonkey-el-${PV}

SITEFILE=50mldonkey-gentoo.el

src_compile() {
	elisp-comp ml*.el
}
