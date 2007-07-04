# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/circe-cvs/circe-cvs-20060810.ebuild,v 1.4 2007/07/04 22:46:49 opfer Exp $

ECVS_SERVER="cvs.savannah.nongnu.org:/sources/circe"
ECVS_MODULE="circe"
ECVS_USER="anonymous"
ECVS_CVS_OPTIONS="-dP"

inherit elisp cvs

DESCRIPTION="A great IRC client for Emacs - CVS"
HOMEPAGE="http://www.nongnu.org/circe/"
SRC_URI=""

LICENSE="GPL-2 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

S=${WORKDIR}/${ECVS_MODULE}
SITEFILE="50${PN}-gentoo.el"


src_compile() {
	emake compile circe.info || die "emake failed"
}

src_install() {
	elisp_src_install
	dodoc COPYING COPYING.FDL FAQ README
	doinfo circe.info*
}
