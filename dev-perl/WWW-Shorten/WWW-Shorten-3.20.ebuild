# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WWW-Shorten/WWW-Shorten-3.20.ebuild,v 1.1 2011/01/13 18:44:26 tove Exp $

EAPI=3

MODULE_AUTHOR=DAVECROSS
MODULE_VERSION=3.02
inherit perl-module

DESCRIPTION="Interface to URL shortening sites"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/libwww-perl
	dev-perl/URI"
DEPEND="virtual/perl-Module-Build"
#	test? ( ${RDEPEND}
#		dev-perl/Test-Pod
#		dev-perl/Test-Pod-Coverage )"

# online tests
SRC_TEST=skip

src_prepare() {
	perl-module_src_prepare
	sed -i -e '/Config::Auto/d' "${S}"/Build.PL || die
}

src_install() {
	perl-module_src_install

	docinto example
	dodoc "${S}"/bin/shorten || die
	rm -f "${D}"/usr/bin/shorten "${D}"/usr/share/man/man1/shorten.1 || die
}
