# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/RPC-XML/RPC-XML-0.54.ebuild,v 1.11 2007/05/12 12:32:56 chtekk Exp $

inherit perl-module

DESCRIPTION="A  Perl extension interface to James Clark's XML parser, expat."
SRC_URI="mirror://cpan/authors/id/R/RJ/RJRAY/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rjray/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/libwww-perl
	>=dev-perl/XML-Parser-2.31
	dev-lang/perl"

pkg_postinst() {
	perl-module_pkg_postinst

	SETWARN=0
	has_version '=net-www/apache-2*' && HAVE_APACHE2=1
	has_version '>=www-apache/mod_perl-2.0' && HAVE_MP2=2

	[ -n "${HAVE_APACHE2}" ] && SETWARN=1
	[ -n "${HAVE_MP2}" ] && SETWARN=1

	if [ "$SETWARN" == "1" ]; then
	ewarn "Apache2 or mod_perl2 were detected."
	ewarn ""
	ewarn "NOTE FROM THE AUTHOR OF RPC-XML"
	ewarn ""
	ewarn "At present, this package does not work with Apache2 and the soon-to-be"
	ewarn "mod_perl2. The changes to the API for location handlers are too drastic to"
	ewarn "try and support both within the same class (I tried, using the compatibility"
	ewarn "layer). Also, mp2 does not currently provide support for <Perl> sections, which"
	ewarn "are the real strength of the Apache::RPC::Server class."
	fi
}
