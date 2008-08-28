# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/python-mode/python-mode-1.0-r1.ebuild,v 1.6 2008/08/28 06:08:11 ulm Exp $

inherit elisp distutils

DESCRIPTION="An Emacs major mode for editing Python source"
HOMEPAGE="http://sourceforge.net/projects/python-mode/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa ia64 ppc ppc64 ~s390 ~sh x86 ~x86-fbsd"
IUSE="pymacs"

DEPEND="pymacs? ( app-emacs/pymacs )"
RDEPEND="${DEPEND}"

SITEFILE=60${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	if use pymacs; then
		cp "${FILESDIR}"/setup.py "${S}"
	else
		rm -f "${S}"/pycomplete.{el,py}
	fi
}

src_compile() {
	elisp_src_compile
	use pymacs && distutils_src_compile
}

src_install() {
	elisp-install ${PN} *.{el,elc} || die
	if use pymacs; then
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
		distutils_src_install
	else
		# remove autoload for pycomplete from site file
		sed '/pycomplete/d' "${FILESDIR}/${SITEFILE}" >"${T}/${SITEFILE}" \
			|| die "sed failed"
		elisp-site-file-install "${T}/${SITEFILE}" || die
	fi
}

pkg_postinst() {
	elisp_pkg_postinst
	use pymacs && distutils_pkg_postinst
}

pkg_postrm() {
	elisp_pkg_postrm
	use pymacs && distutils_pkg_postrm
}
