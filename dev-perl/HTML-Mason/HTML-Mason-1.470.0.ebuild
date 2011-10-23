# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Mason/HTML-Mason-1.470.0.ebuild,v 1.1 2011/10/23 07:14:10 tove Exp $

EAPI=4

MODULE_AUTHOR=DROLSKY
MODULE_VERSION=1.47
inherit depend.apache perl-module

DESCRIPTION="A HTML development and delivery Perl Module"
HOMEPAGE="http://www.masonhq.com/ ${HOMEPAGE}"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="modperl doc test"

RDEPEND="!modperl? ( virtual/perl-CGI )
	modperl? (
		www-apache/libapreq2
		>=www-apache/mod_perl-2
	)
	>=dev-perl/Params-Validate-0.7
	>=dev-perl/Class-Container-0.08
	>=dev-perl/Exception-Class-1.15
	dev-perl/HTML-Parser
	virtual/perl-Scalar-List-Utils
	virtual/perl-File-Spec
	>=dev-perl/Cache-Cache-1.01
	dev-perl/Log-Any"

DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( dev-perl/Test-Deep )"

want_apache2 modperl

SRC_TEST="do"
mydoc="CREDITS UPGRADE"
myconf="--noprompts"

pkg_setup() {
	depend.apache_pkg_setup modperl
	perl-module_pkg_setup
}

perl-module_src_prep() {
	# Note about new modperl use flag
	if use !modperl ; then
		ewarn "HTML-Mason will only install with modperl support"
		ewarn "if the use flag modperl is enabled."
		sleep 5
	fi
	# rendhalver - needed to set an env var for the build script so it finds our apache.
	APACHE="${APACHE_BIN}" perl "${S}"/Build.PL installdirs=vendor destdir="${ED}" ${myconf}
}

src_install () {
	perl-module_src_install
	rm "${ED}"/usr/bin/*.README # 368937
	# rendhalver - the html docs have subdirs so this gets all of them
	use doc && dohtml -r htdocs/*
}
