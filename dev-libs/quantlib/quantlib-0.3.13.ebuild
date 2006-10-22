# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/quantlib/quantlib-0.3.13.ebuild,v 1.1 2006/10/22 19:01:40 dev-zero Exp $

inherit autotools eutils

KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

MY_P=QuantLib-${PV}
DESCRIPTION="A comprehensive software framework for quantitative finance"
HOMEPAGE="http://www.quantlib.org"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
SLOT="0"
LICENSE="BSD"
IUSE="doc emacs examples"

RDEPEND="dev-libs/boost"
DEPEND="sys-devel/libtool
	emacs? ( virtual/emacs )
	doc? ( app-doc/doxygen )
	${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PV}-destdir.patch"
	epatch "${FILESDIR}/${PV}-boost_mt.patch"

	sed -i \
		-e 's/qlintro.tex quantlibheader.tex //' \
		Docs/Makefile.in || die "sed failed"

	eautoreconf
}

src_compile() {
	use emacs ||
		sed -i -e "s/^EMACS=.*/EMACS=no/" configure || die "sed failed"

	econf || die "econf failed"
	emake || die "emake failed"

	if use doc ; then
		cd "${S}/Docs"
		emake docs-online || die "emake docs-html failed"
	fi
}

src_install(){
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc *.txt

	if use doc ; then
		cd "${S}/Docs"
		dohtml html-online/*
	fi

	if use examples ; then
		cd "${S}/Examples"
		insinto /usr/share/doc/${PF}/examples
		doins *.txt
		for example in $(ls -d */); do
			doins ${example%%/}/*.{cpp,h,txt}
		done
	fi
}
