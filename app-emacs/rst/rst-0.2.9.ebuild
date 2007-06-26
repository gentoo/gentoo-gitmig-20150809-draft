# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/rst/rst-0.2.9.ebuild,v 1.1 2007/06/26 19:15:01 ulm Exp $

inherit elisp

MY_PN=rst-mode
DESCRIPTION="A major mode for editing reStructuredText"
HOMEPAGE="http://www.merten-home.de/FreeSoftware/rst-mode/index.html
	http://www.emacswiki.org/cgi-bin/wiki/reStructuredText"
SRC_URI="mirror://gentoo/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
IUSE=""

SITEFILE=50${MY_PN}-gentoo.el
S="${WORKDIR}/${MY_PN}-${PV}"

src_install() {
	elisp-install ${MY_PN} *.el *.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" ${MY_PN}
}
