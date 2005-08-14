# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Mason/HTML-Mason-1.30.ebuild,v 1.2 2005/08/14 21:50:55 ferdy Exp $

inherit perl-module

DESCRIPTION="A HTML development and delivery Perl Module"
SRC_URI="mirror://cpan/authors/id/D/DR/DROLSKY/${P}.tar.gz"
HOMEPAGE="http://www.masonhq.com/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
#KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="apache2 modperl"
SRC_TEST="do"

DEPEND="${DEPEND}
	!modperl? ( perl-core/CGI )
	modperl? (
		!apache2? (
			=net-www/apache-1*
			>=www-apache/libapreq-1.0-r2
			<www-apache/mod_perl-2* )
		apache2? (
			>=net-www/apache-2
			www-apache/libapreq2
			>=www-apache/mod_perl-2* )
	)
	>=dev-perl/Params-Validate-0.24-r2
	dev-perl/module-build
	>=dev-perl/Class-Container-0.08
	>=dev-perl/Exception-Class-1.14
	dev-perl/Scalar-List-Utils
	|| ( perl-core/File-Spec >=dev-lang/perl-5.8.0-r12 )
	>=dev-perl/Cache-Cache-1.01"

mydoc="CREDITS UPGRADE"
myconf="--noprompts"


perl-module_src_prep() {
	# Note about new modperl use flag
	if use !modperl ; then
		ewarn "HTML-Mason will only install with modperl support"
		ewarn "if the use flag modperl is enabled."
		sleep 5
	fi
	# rendhalver - needed to set an env var for the build script so it finds our apache.
	if use apache2; then
		APACHE="/usr/sbin/apache2"
	else
		APACHE="/usr/sbin/apache"
	fi

	APACHE="${APACHE}" perl ${S}/Build.PL installdirs=vendor destdir=${D} ${myconf}
}

src_install () {
	perl-module_src_install
	# rendhalver - the html docs have subdirs so this gets all of them
	dohtml -r htdocs/*
}
