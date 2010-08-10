# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WWW-Mechanize/WWW-Mechanize-1.64.ebuild,v 1.1 2010/08/10 15:37:20 robbat2 Exp $

EAPI=2

MODULE_AUTHOR=PETDANCE
inherit perl-module

DESCRIPTION="Handy web browsing in a Perl object"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

# Bug in the tests - improper use of HTTP::Server
SRC_TEST="do"

# configure to run the local tests, but not the ones which access the Internet
myconf="--local --nolive"

RDEPEND="dev-perl/IO-Socket-SSL
	>=dev-perl/libwww-perl-5.829
	>=dev-perl/URI-1.36
	>=dev-perl/HTML-Parser-3.34
	dev-perl/Test-LongString"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
		dev-perl/Test-NoWarnings
		dev-perl/Test-Taint
		>=dev-perl/Test-Warn-0.11
		dev-perl/Test-Memory-Cycle )"
#		dev-perl/HTTP-Server-Simple )"

# Remove test until the bug is fixed:
# http://rt.cpan.org/Public/Bug/Display.html?id=41673
src_prepare() {
	mv "${S}"/t/cookies.t{,.disable} || die
	sed -i "/cookies.t/d" "${S}/MANIFEST" || die
	perl-module_src_prepare
}
