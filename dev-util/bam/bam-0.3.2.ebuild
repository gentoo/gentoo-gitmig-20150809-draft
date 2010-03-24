# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bam/bam-0.3.2.ebuild,v 1.1 2010/03/24 23:25:56 volkmar Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Fast and flexible Lua-based build system"
HOMEPAGE="http://matricks.github.com/bam/"
SRC_URI="http://github.com/downloads/matricks/${PN}/${P}.tar.bz2
	mirror://gentoo/${P}-gentoo.tar.bz2"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc test"

RDEPEND="dev-lang/lua"
DEPEND="${RDEPEND}
	doc? ( dev-lang/python )
	test? ( dev-lang/python )"

src_prepare() {
	cp "${WORKDIR}"/Makefile "${S}"/Makefile || die "cp failed"

	if use doc; then
		sed -i -e "s/base\.bam/base\.lua/" scripts/gendocs.py \
			|| die "sed failed"
	fi

	if use test; then
		epatch "${WORKDIR}"/${P}-test.py.patch
	fi
}

src_compile() {
	emake txt2c || die "emake failed"
	emake internal_base || die "emake failed"
	emake ${PN} || die "emake failed"

	if use doc; then
		python scripts/gendocs.py || die "doc generation failed"
	fi
}

src_install() {
	dobin ${PN} || die "dobin failed"
	doman "${WORKDIR}"/${PN}.1 || die "doman failed"

	if use doc; then
		dohtml docs/${PN}{.html,_logo.png} || die "dohtml failed"
	fi
}
