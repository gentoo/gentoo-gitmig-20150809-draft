# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/wxglade/wxglade-0.6.1.ebuild,v 1.2 2007/12/04 15:42:07 dirtyepic Exp $

inherit python multilib eutils

MY_P="wxGlade-${PV}"
DESCRIPTION="Glade-like GUI designer which can generate Python, Perl, C++ or XRC code"
HOMEPAGE="http://wxglade.sourceforge.net/"
SRC_URI="mirror://sourceforge/wxglade/${MY_P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
S="${WORKDIR}/${MY_P}"
DEPEND=">=dev-lang/python-2.3
	=dev-python/wxpython-2.6*"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-wxversion.patch
}

src_install() {
	python_version
	dodir /usr/$(get_libdir)/python${PYVER}/site-packages/${PN}
	dodoc CHANGES.txt README.txt TODO.txt credits.txt
	cp credits.txt "${D}"/usr/$(get_libdir)/python${PYVER}/site-packages/${PN}/
	dohtml -r docs/*
	rm -rf docs *txt
	cp -R * "${D}"/usr/$(get_libdir)/python${PYVER}/site-packages/${PN}/
	dosym /usr/share/doc/${PF}/html /usr/$(get_libdir)/python${PYVER}/site-packages/${PN}/docs
	echo "#!/bin/bash" > wxglade
	echo "exec python /usr/$(get_libdir)/python${PYVER}/site-packages/${PN}/wxglade.py \$*" >> wxglade
	exeinto /usr/bin
	doexe wxglade
	insinto /usr/share/pixmaps
	newins icons/icon.xpm wxglade.xpm
	make_desktop_entry wxglade wxGlade wxglade "Development;GUIDesigner"
}

pkg_postinst() {
	python_mod_optimize "${ROOT}"usr/$(get_libdir)/python*/site-packages/wxglade
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}"usr/$(get_libdir)/python*/site-packages/wxglade
}
