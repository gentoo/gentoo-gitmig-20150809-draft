# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/fann/fann-1.2.0.ebuild,v 1.1 2004/12/04 11:39:21 satya Exp $

inherit eutils
#-----------------------------------------------------------------------------
DESCRIPTION="Fast Artificial Neural Network Library implements multilayer artificial neural networks in C"
HOMEPAGE="http://fann.sourceforge.net/"
SRC_URI="mirror://sourceforge/fann/${PF}.tar.bz2"
#-----------------------------------------------------------------------------
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc python"
#-----------------------------------------------------------------------------
DEPEND="sys-devel/autoconf
	sys-apps/sed
	doc? ( app-text/docbook-sgml-utils )
	python? ( dev-lang/python dev-lang/swig )"
#-----------------------------------------------------------------------------
S=${WORKDIR}/${PF}
#=============================================================================
src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	cp ${FILESDIR}/${PF}-setup.py ${S}/python/setup.py
}
#=============================================================================
src_compile() {
	local myconf
	myconf="--prefix=/usr"
	cd ${S} || die
	econf ${myconf} || die
	emake || die
	if use python; then
		einfo "python ------------------------------"
		cd ${S}/python || die
		mkdir fann
		for f in `ls *py |grep -v setup.py`; do
			mv $f fann || die
		done
	fi
}
#=============================================================================
src_install() {
	cd ${S}
	make install DESTDIR=${D} || die
	if use doc; then
		einfo "doc ---------------------------------"
		dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
		insinto /usr/share/doc/${PF}/benchmarks
		cp -a ${S}/benchmarks/* ${D}/usr/share/doc/${PF}/benchmarks
		insinto /usr/share/doc/${PF}/examples/c
		doins ${S}/examples/*
		insinto /usr/share/doc/${PF}/html
		cp -a doc/html/* ${D}/usr/share/doc/${PF}/html
		insinto /usr/share/doc/${PF}/pdf
		doins doc/*pdf
	fi
	if use python; then
		einfo "python ------------------------------"
		cd ${S}/python || die
		python setup.py install --root=${D} || die "No python"
		if use doc; then
			local python_doc_dir="/usr/share/doc/${PF}/examples/python"
			insinto ${python_doc_dir}
			doins examples/*py
			dosym ../../benchmarks/datasets ${python_doc_dir}/
		fi
	fi
}

