# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/rst/rst-0.4.ebuild,v 1.6 2007/06/27 13:15:59 angelos Exp $

inherit elisp

DESCRIPTION="ReStructuredText support for Emacs"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/reStructuredText"
SRC_URI="mirror://sourceforge/docutils/docutils-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc64 sparc x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}/docutils-${PV}/tools/editors/emacs"
SITEFILE=50${PN}-gentoo.el
DOCS="README.txt"

# this can be removed once the new elisp.eclass is in the tree
src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	if [ -n "${DOCS}" ]; then
		dodoc ${DOCS} || die "dodoc failed"
	fi
}
