# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/RPC-XML/RPC-XML-0.54.ebuild,v 1.3 2004/07/14 20:21:12 agriffis Exp $

inherit perl-module

DESCRIPTION="A  Perl extension interface to James Clark's XML parser, expat."
SRC_URI="http://cpan.valueclick.com/modules/by-module/RPC/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/RPC/${PN}.${PV}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"
IUSE="apache2"

SRC_TEST="do"

DEPEND="dev-perl/libwww-perl
	>=dev-perl/XML-Parser-2.31
	!apache2? ( <dev-perl/mod_perl-1.99* )"

pkg_postinst() {
	perl-module_pkg_postinst

	SETWARN=0
	has_version '=net-www/apache-2*' && HAVE_APACHE2=1
	has_version '>=dev-perl/mod_perl-1.99*' && HAVE_MP2=2

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
