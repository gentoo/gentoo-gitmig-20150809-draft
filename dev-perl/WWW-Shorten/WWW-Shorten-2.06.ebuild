# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WWW-Shorten/WWW-Shorten-2.06.ebuild,v 1.2 2009/12/05 14:58:54 tove Exp $

EAPI=2

MODULE_AUTHOR=DAVECROSS
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

src_install() {
	perl-module_src_install

	docinto example
	dodoc "${S}"/bin/shorten || die
	rm -f "${D}"/usr/bin/shorten "${D}"/usr/share/man/man1/shorten.1 || die
}
