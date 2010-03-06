# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/wxglade/wxglade-0.6.3.ebuild,v 1.7 2010/03/06 05:42:22 dirtyepic Exp $

EAPI="2"

inherit eutils multilib python

MY_P="wxGlade-${PV}"

DESCRIPTION="Glade-like GUI designer which can generate Python, Perl, C++ or XRC code"
HOMEPAGE="http://wxglade.sourceforge.net/"
SRC_URI="mirror://sourceforge/wxglade/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND="dev-python/wxpython:2.8"
PYTHON_DEPEND="2:2.3"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-wxversion.patch
}

src_install() {
	dodoc CHANGES.txt README.txt TODO.txt credits.txt

	pydir=$(python_get_sitedir)/wxglade

	dodir "${pydir}"
	mv "${S}"/credits.txt "${D}${pydir}"
	dohtml -r "${S}"/docs/*
	rm -rf docs *txt

	cp -R "${S}"/* "${D}${pydir}"
	dosym /usr/share/doc/${PF}/html "${pydir}"/docs

	cat > "${S}"/wxglade <<-EOF
		#!/bin/sh
		$(PYTHON) ${pydir}/wxglade.py \$*
	EOF

	exeinto /usr/bin
	doexe "${S}"/wxglade

	insinto /usr/share/pixmaps
	newins icons/icon.xpm wxglade.xpm

	make_desktop_entry wxglade wxGlade wxglade "Development;GUIDesigner"
}

pkg_postinst() {
	python_mod_optimize "$(python_get_sitedir)"/wxglade
}

pkg_postrm() {
	python_mod_cleanup "$(python_get_sitedir)"/wxglade
}
