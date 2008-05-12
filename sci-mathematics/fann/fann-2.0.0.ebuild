# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/fann/fann-2.0.0.ebuild,v 1.6 2008/05/12 13:10:17 markusle Exp $

inherit eutils

DESCRIPTION="Fast Artificial Neural Network Library implements multilayer artificial neural networks in C"
HOMEPAGE="http://leenissen.dk/fann/"
SRC_URI="mirror://sourceforge/fann/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc python"

RDEPEND="python? ( dev-lang/python )"
DEPEND="${RDEPEND}
		python? ( dev-lang/swig )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-shared-libs-gentoo.patch
	epatch "${FILESDIR}"/${P}-benchmark.patch
}

src_compile() {
	econf ${myconf} || die "configure failed"
	emake || die "failed to build src"
	if use python; then
		cd "${S}"/python || \
			die "failed to step into python subdirectory"
		emake || die "failed to build python wrappers"
		cd "${S}"
	fi
}

src_install() {
	make install DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO

	if use doc; then
		dodoc doc/*.txt || \
			die "failed to install docs"
		insinto /usr/share/doc/${P}
		doins doc/fann_en.pdf || \
			die "failed to install reference manual"
		insinto /usr/share/${PN}/benchmarks
		doins -r benchmarks/* || \
			die "failed to install benchmarks"
		insinto /usr/share/${PN}/examples
		doins examples/* || \
			die "failed to install examples"
	fi

	if use python; then
		cd "${S}"/python || \
			die "Faild to step into python subdirectory"
		make install ROOT="${D}" || \
			die "failed to install python wrappers"
		if use doc; then
			local python_doc_dir="/usr/share/${PN}/examples/python"
			insinto ${python_doc_dir}
			doins examples/* || \
				die "failed to install python examples"
		fi
	fi
}
