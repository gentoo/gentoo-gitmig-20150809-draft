# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/python-mode/python-mode-4.63-r1.ebuild,v 1.2 2004/12/08 17:03:48 blubb Exp $

inherit distutils elisp

IUSE=""

MY_P="${PN}-1.0alpha"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Python Mode is a major editing mode for the XEmacs and FSF Emacs text editors."
HOMEPAGE="http://sourceforge.net/projects/python-mode/"
SRC_URI="mirror://sourceforge/python-mode/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc-macos ~amd64"

DEPEND="app-emacs/pymacs"

SITEFILE="55python-mode-gentoo.el"

src_compile() {
	elisp-comp *.el || die
}

src_install() {
	elisp-install ${PN} *.el *.elc
	distutils_python_version
	insinto /usr/lib/python${PYVER}/site-packages
	doins pycomplete.py
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}
