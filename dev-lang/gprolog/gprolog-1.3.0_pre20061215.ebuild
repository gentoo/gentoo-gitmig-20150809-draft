# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gprolog/gprolog-1.3.0_pre20061215.ebuild,v 1.1 2006/12/31 06:44:45 keri Exp $

inherit eutils versionator

MY_PV=$(get_version_component_range 1-3)
MY_P=${PN}-${MY_PV}

DESCRIPTION="GNU Prolog is a native Prolog compiler with constraint solving over finite domains (FD)"
HOMEPAGE="http://pauillac.inria.fr/~diaz/gnu-prolog/"
SRC_URI="ftp://ftp.inria.fr/INRIA/Projects/contraintes/gprolog/unstable/gprolog-20061215.tgz"
S=${WORKDIR}/${MY_P}/src

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~x86"
IUSE="doc examples"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${MY_P}-TXT_FILES.patch
	epatch "${FILESDIR}"/${MY_P}-test.patch
}

src_compile() {
	econf \
		--with-c-flags="${CFLAGS}" \
		--with-install-dir="${D}"/usr \
		--with-doc-dir="${D}"/usr/share/doc/${PF} \
		--with-html-dir="${D}"/usr/share/doc/${PF}/html \
		--with-examples-dir="${D}"/usr/share/doc/${PF}/examples \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make install-system || die "make install-system failed"

	if use doc; then
		make install-html || die "make install-html failed"
	fi
	if use examples; then
		make install-examples || die "make install-examples failed"
	fi

	cd "${S}"/..
	dodoc ChangeLog NEWS PROBLEMS README VERSION
}
