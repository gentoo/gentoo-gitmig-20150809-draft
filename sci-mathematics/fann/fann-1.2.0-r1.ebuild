# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/fann/fann-1.2.0-r1.ebuild,v 1.5 2008/05/12 13:10:17 markusle Exp $

inherit eutils

MY_PKG_NAME=${PN}-${PV/-.*/}
DESCRIPTION="Fast Artificial Neural Network Library implements multilayer artificial neural networks in C"
HOMEPAGE="http://fann.sourceforge.net/"
SRC_URI="mirror://sourceforge/fann/${MY_PKG_NAME}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc python"

RDEPEND="python? ( dev-lang/python )"
DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-apps/sed
	doc? ( app-text/docbook-sgml-utils )
	python? ( dev-lang/swig )"

S=${WORKDIR}/${MY_PKG_NAME}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PF}.patch
}

src_compile() {
	local myconf
	myconf="--prefix=/usr"

	econf ${myconf} || die "econf failed!"
	emake || die "emake failed!"

	if use python; then
		cd "${S}"/python
		#mkdir fann
		#for f in `ls *py |grep -v setup.py`; do
		#	mv $f fann || die
		#done
		python setup_unix.py build
		cd "${S}"
	fi
}

src_install() {
	make install DESTDIR="${D}" || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO

	if use doc; then
		insinto /usr/share/doc/${PF}/benchmarks
		cp -pPR "${S}"/benchmarks/* "${D}"/usr/share/doc/${PF}/benchmarks
		insinto /usr/share/doc/${PF}/examples/c
		doins "${S}"/examples/*
		insinto /usr/share/doc/${PF}/html
		cp -pPR doc/html/* "${D}"/usr/share/doc/${PF}/html
		insinto /usr/share/doc/${PF}/pdf
		doins doc/*pdf
	fi

	if use python; then
		cd "${S}"/python
		python setup_unix.py install --root="${D}" || die "python setup failed!"
		if use doc; then
			local python_doc_dir="/usr/share/doc/${PF}/examples/python"
			insinto ${python_doc_dir}
			doins examples/*py
			dosym ../../benchmarks/datasets ${python_doc_dir}/
		fi
	fi
}
