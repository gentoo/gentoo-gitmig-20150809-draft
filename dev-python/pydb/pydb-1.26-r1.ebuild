# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pydb/pydb-1.26-r1.ebuild,v 1.1 2011/12/24 15:41:51 maksbotan Exp $

EAPI=4

PYTHON_DEPEND="2:2.4"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_EXPORT_PHASE_FUNCTIONS="1"

inherit elisp-common python

DESCRIPTION="Extended python debugger"
HOMEPAGE="http://bashdb.sourceforge.net/pydb/"
SRC_URI="mirror://sourceforge/bashdb/${P}.tar.bz2"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="emacs"

DEPEND="
	emacs? ( virtual/emacs )"
RDEPEND="${DEPEND}"

# This package uses not distutils but the usual
# ./configure; make; make install
# The default src_compile is OK

src_configure() {
	configuration() {
		econf --with-lispdir="${SITELISP}/${PN}" \
			EMACS="$(use emacs && echo "${EMACS}" || echo no)" \
			--with-site-packages=$(python_get_sitedir) \
			--with-python=$(PYTHON -a)
	}
	python_execute_function -s configuration
}

src_install() {
	installation(){
		emake DESTDIR="${D}" install || die "emake install failed"
		mv "${ED}"/usr/bin/${PN} "${ED}"/usr/bin/${PN}-${PYTHON_ABI} || die
	}
	python_execute_function -s installation
	python_generate_wrapper_scripts "${ED}"/usr/bin/${PN}

	dodoc AUTHORS ChangeLog NEWS README THANKS TODO || die "dodoc failed"
}
