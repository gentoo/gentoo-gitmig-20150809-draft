# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bicyclerepair/bicyclerepair-0.9-r2.ebuild,v 1.4 2009/04/26 19:29:26 ranger Exp $

inherit distutils elisp-common eutils

DESCRIPTION="Bicycle Repair Man is the Python Refactoring Browser"
HOMEPAGE="http://bicyclerepair.sourceforge.net/"
SRC_URI="mirror://sourceforge/bicyclerepair/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ppc ppc64 x86"
IUSE="emacs"

DEPEND="virtual/python
	emacs? ( app-emacs/pymacs
		app-emacs/python-mode )"

SITEFILE=50${PN}-gentoo.el
PYTHON_MODNAME="bike"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# bikeemacs.py contains non-ascii characters in comments
	sed -i -e '1s/$/\t-*- coding: latin-1 -*-/' ide-integration/bikeemacs.py
	epatch "${FILESDIR}"/${P}-idle.patch
	epatch "${FILESDIR}"/${P}-invalid-syntax.patch
}

src_install() {
	distutils_src_install
	if use emacs; then
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	fi
}

pkg_postinst() {
	python_version
	# Enable IDLE integration if Python was compiled with tcltk.
	config_txt="${ROOT}"/usr/lib/python${PYVER}/tools/idle/config.txt
	if [ -f "${config_txt}" ];
	then
		if [ -z "`grep BicycleRepairMan_Idle ${config_txt}`" ]; then
			elog "Appending BicycleRepairman to IDLE.."
			echo "[BicycleRepairMan_Idle]" >> ${config_txt}
		fi
	else
		elog "BicycleRepairMan won't integrate with IDLE"
	fi
	use emacs && elisp-site-regen

	distutils_pkg_postinst
	python_mod_optimize $(python_get_sitedir)/bikeemacs.py
	python_mod_optimize $(python_get_sitedir)/BicycleRepairMan_Idle.py
}

pkg_postrm() {
	use emacs && elisp-site-regen
	python_mod_cleanup
}
