# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perltidy/perltidy-20090616.ebuild,v 1.2 2010/01/10 20:00:05 grobian Exp $

EAPI=2

MY_PN=Perl-Tidy
MY_P=${MY_PN}-${PV}
MODULE_AUTHOR=SHANCOCK
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Perl script indenter and beautifier."
HOMEPAGE="http://perltidy.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

SRC_TEST="do"

src_install() {
	perl-module_src_install
	docinto examples
	dodoc "${S}"/examples/*
}

pkg_postinst() {
	elog "Example scripts can be found in /usr/share/doc/${PF}"
}
