# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/crypt++/crypt++-2.92.ebuild,v 1.2 2007/01/23 06:19:49 opfer Exp $

inherit elisp

IUSE=""

DESCRIPTION="Handle all sorts of compressed and encrypted files"
HOMEPAGE="http://freshmeat.net/projects/crypt/
	http://packages.debian.org/unstable/editors/crypt++el.html"
SRC_URI="mirror://debian/pool/main/c/crypt++el/crypt++el_${PV}.orig.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
RESTRICT="mirror"
DEPEND="virtual/emacs"

SITEFILE=50crypt++-gentoo.el

S=${WORKDIR}/${PN}el-${PV}

src_compile() {
	elisp-comp *.el
}

src_install() {
	elisp-install ${PN} *.{el,elc}
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}
