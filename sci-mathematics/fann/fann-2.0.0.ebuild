# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/fann/fann-2.0.0.ebuild,v 1.8 2012/02/25 03:24:24 patrick Exp $

EAPI=2

PYTHON_DEPEND="python? 2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit eutils python

MY_P=${P/_/}

DESCRIPTION="Fast Artificial Neural Network Library"
HOMEPAGE="http://leenissen.dk/fann/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc python"

RDEPEND=""
DEPEND="
	${RDEPEND}
	python? ( dev-lang/swig )"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-shared-libs-gentoo.patch \
		"${FILESDIR}"/${P}-benchmark.patch
	use python && python_copy_sources python
}

src_compile() {
	emake || die "failed to build src"
	compilation() {
		emake PYTHON_VERSION="$(python_get_version)" || die "emake python failed"
	}
	use python && python_execute_function -s --source-dir python compilation
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || die

	if use doc; then
		dodoc doc/*.txt || \
			die "failed to install docs"
		insinto /usr/share/doc/${PF}
		doins doc/fann_en.pdf || \
			die "failed to install reference manual"
		insinto /usr/share/${PN}
		doins -r benchmarks || \
			die "failed to install benchmarks"
		doins -r examples || \
			die "failed to install examples"
	fi

	installation() {
		emake install ROOT="${D}" || die "failed to install python wrappers"
		if use doc; then
			insinto /usr/share/doc/${PF}/examples/python
			doins -r examples || die "failed to install python examples"
		fi
	}
	use python && python_execute_function -s --source-dir python installation
}

pkg_postinst() {
	python_mod_optimize py${PN}
}

pkg_postrm() {
	python_mod_cleanup py${PN}
}
