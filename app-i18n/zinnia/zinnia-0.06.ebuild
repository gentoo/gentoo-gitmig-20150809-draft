# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/zinnia/zinnia-0.06.ebuild,v 1.1 2010/11/04 13:38:00 matsuu Exp $

EAPI="3"

inherit perl-module

DESCRIPTION="Online hand recognition system with machine learning"
HOMEPAGE="http://zinnia.sourceforge.net/"
SRC_URI="mirror://sourceforge/zinnia/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
#IUSE="perl python ruby"
IUSE="perl"

src_prepare() {
	base_src_prepare

	if use perl ; then
		(
			cd "${S}/perl"
			perl-module_src_prepare
		)
	fi
}

src_configure() {
	base_src_configure

	if use perl ; then
		(
			cd "${S}/perl"
			perl-module_src_configure
		)
	fi
}

src_compile() {
	base_src_compile

	if use perl ; then
		(
			cd "${S}/perl"
			perl-module_src_compile
		)
	fi
}

src_test() {
	base_src_test

	if use perl ; then
		(
			cd "${S}/perl"
			perl-module_src_test
		)
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die

	if use perl ; then
		(
			cd "${S}/perl"
			perl-module_src_install
		)
	fi

	dodoc AUTHORS ChangeLog NEWS README || die
	dohtml doc/*.html doc/*.css || die
}
