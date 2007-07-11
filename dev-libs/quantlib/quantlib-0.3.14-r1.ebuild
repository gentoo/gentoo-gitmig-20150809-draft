# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/quantlib/quantlib-0.3.14-r1.ebuild,v 1.1 2007/07/11 21:00:20 ulm Exp $

inherit autotools eutils elisp-common

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

SITEFILE=50${PN}-gentoo.el

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e 's/qlintro.tex quantlibheader.tex //' \
		Docs/Makefile.in || die "sed failed"

	eautoconf
}

src_compile() {
	use emacs ||
		sed -i -e "s/^EMACS=.*/EMACS=no/" configure || die "sed failed"

	econf --with-lispdir="${SITELISP}/${PN}" || die "econf failed"
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

	if use emacs; then
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
