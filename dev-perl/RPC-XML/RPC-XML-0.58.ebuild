# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/RPC-XML/RPC-XML-0.58.ebuild,v 1.2 2005/08/26 03:16:07 agriffis Exp $

inherit perl-module

DESCRIPTION="A  Perl extension interface to James Clark's XML parser, expat."
SRC_URI="mirror://cpan/authors/id/R/RJ/RJRAY/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rjray/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="apache2"

#SRC_TEST="do"

DEPEND=">=dev-perl/libwww-perl-5.801
	>=dev-perl/XML-LibXML-1.58
	>=dev-perl/XML-Parser-2.31
	dev-perl/net-server
	!apache2? ( <www-apache/mod_perl-1.99 )"

pkg_postinst() {
	perl-module_pkg_postinst

	SETWARN=0
	has_version '=net-www/apache-2*' && HAVE_APACHE2=1
	has_version '>=www-apache/mod_perl-1.99' && HAVE_MP2=2

	[ -n "${HAVE_APACHE2}" ] && SETWARN=1
	[ -n "${HAVE_MP2}" ] && SETWARN=1

	if [ "$SETWARN" == "1" ]; then
	einfo "Apache2 or mod-perl-1.99 (mod_perl2) were detected."
	einfo ""
	einfo "NOTE FROM THE AUTHOR OF RPC-XML"
	einfo ""
	einfo "At present, this package does not work with Apache2 and the soon-to-be"
	einfo "mod_perl2. The changes to the API for location handlers are too drastic to"
	einfo "try and support both within the same class (I tried, using the compatibility"
	einfo "layer). Also, mp2 does not currently provide support for <Perl> sections, which"
	einfo "are the real strength of the Apache::RPC::Server class."
	fi
}
