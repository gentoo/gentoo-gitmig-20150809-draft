# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qwt/qwt-4.2.0-r2.ebuild,v 1.1 2007/08/23 13:01:00 caleb Exp $

inherit multilib qt3

SRC_URI="mirror://sourceforge/qwt/${P}.tar.bz2"
HOMEPAGE="http://qwt.sourceforge.net/"
DESCRIPTION="2D plotting library for Qt"
LICENSE="qwt"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"
SLOT="0"
IUSE="doc examples"

DEPEND="$(qt_min_version 3)"

src_compile () {
	# Remove hardcoded -fno-exceptions from CXXFLAGS
	find . -type f -name "*.pro" | while read file; do
		sed -i -e 's/-fno-exceptions//g' ${file} \
			|| die "sed failed"
	done

	# Set include path for bundled examples
	find examples -type f -name "*.pro" | while read file; do
		echo >> ${file} "INCLUDEPATH += /usr/include/qwt"
	done

	eqmake3
	emake || die "emake failed"

	cd designer
	eqmake3 qwtplugin.pro
	emake || die "emake designer failed"
}

src_install () {
	local QWTVER="${PV}"

	# Library and symlinks
	dolib.so lib/libqwt.so.${QWTVER} \
		|| die "dolib libqwt.so.${QWTVER} failed"
	dosym libqwt.so.${QWTVER} /usr/$(get_libdir)/libqwt.so
	dosym libqwt.so.${QWTVER} /usr/$(get_libdir)/libqwt.so.${QWTVER%%.*}
	dosym libqwt.so.${QWTVER} /usr/$(get_libdir)/libqwt.so.${QWTVER%.*}

	# Header files
	dodir /usr/include/qwt
	insinto /usr/include/qwt
	doins include/* || die "headers installation failed"

	# Designer plugin
	insinto "${QTDIR}"/plugins/designer
	insopts -m0755
	doins designer/plugins/designer/libqwtplugin.so \
		|| die "designer plugin installation failed"

	dodoc CHANGES README

	if use doc; then
		doman doc/man/man3/* || die "doman failed"
		dohtml doc/html/* || die "dohtml failed"
	fi

	if use examples; then
		cp -pPR examples "${D}"/usr/share/doc/${PF}/
	fi
}
