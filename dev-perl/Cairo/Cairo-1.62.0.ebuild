# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cairo/Cairo-1.62.0.ebuild,v 1.2 2011/05/11 08:40:54 xmw Exp $

EAPI=4

MODULE_AUTHOR=TSCH
MODULE_VERSION=1.062
inherit perl-module

DESCRIPTION="Perl interface to the cairo library"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="test"

RDEPEND=">=x11-libs/cairo-1.0.0"
DEPEND="${RDEPEND}
	>=dev-perl/extutils-depends-0.205
	>=dev-perl/extutils-pkgconfig-1.07
	test? ( dev-perl/Test-Number-Delta )"

SRC_TEST="do"

src_prepare() {
	perl-module_src_prepare
	sed -i -e 's,exit 0,exit 1,' "${S}"/Makefile.PL || die
}

src_test() {
	mv "${S}"/t/CairoSurface.t{,.disable} || die
	perl-module_src_test
}
