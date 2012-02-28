# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perltidy/perltidy-20101217.0.0.ebuild,v 1.3 2012/02/28 14:54:47 ranger Exp $

EAPI=4

MY_PN=Perl-Tidy
MODULE_AUTHOR=SHANCOCK
MODULE_VERSION=20101217
inherit perl-module

DESCRIPTION="Perl script indenter and beautifier."
HOMEPAGE="http://perltidy.sourceforge.net/ ${HOMEPAGE}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

SRC_TEST="do"

src_install() {
	perl-module_src_install
	docinto examples
	dodoc "${S}"/examples/*
}
