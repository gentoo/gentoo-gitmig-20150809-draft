# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xbae/xbae-4.60.4.ebuild,v 1.15 2012/02/09 09:46:56 jlec Exp $

EAPI=3
inherit eutils

DESCRIPTION="Motif-based widget to display a grid of cells as a spreadsheet"
HOMEPAGE="http://xbae.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux"
SLOT="0"
IUSE="doc examples"

RDEPEND=">=x11-libs/openmotif-2.3:0
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXmu
	x11-libs/libXpm
	x11-libs/libXt"

DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-tmpl.patch
	epatch "${FILESDIR}"/${P}-lxmp.patch
	epatch "${FILESDIR}"/${P}-Makefile.in.patch
}

src_configure() {
	econf --enable-production
}

src_test() {
	cd examples
	emake || die "emake examples failed"
	./testall
	make clean
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	insinto /usr/share/aclocal
	doins ac_find_xbae.m4 || die
	dodoc README NEWS ChangeLog AUTHORS
	if use doc; then
		dohtml -r doc/* || die
	fi
	if use examples; then
		find examples -name '*akefile*' -exec rm -f {} \;
		rm -f examples/{testall,extest}
		insinto /usr/share/doc/${PF}
		doins -r examples || die
	fi
}
