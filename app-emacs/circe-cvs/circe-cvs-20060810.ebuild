# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/circe-cvs/circe-cvs-20060810.ebuild,v 1.2 2006/08/12 17:45:20 mkennedy Exp $

ECVS_SERVER="cvs.savannah.nongnu.org:/sources/circe"
ECVS_MODULE="circe"
ECVS_USER="anonymous"
ECVS_CVS_OPTIONS="-dP"

inherit elisp cvs

S=${WORKDIR}/${ECVS_MODULE}
DESCRIPTION="Circe - A great IRC client for Emacs - CVS"
HOMEPAGE="http://www.nongnu.org/circe/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
IUSE=""

DEPEND="virtual/emacs"

SITEFILE="50${PN}-gentoo.el"


src_compile() {
	make compile circe.info || die
}

src_install() {
	elisp_src_install
	dodoc COPYING COPYING.FDL FAQ README
	doinfo circe.info*
}
