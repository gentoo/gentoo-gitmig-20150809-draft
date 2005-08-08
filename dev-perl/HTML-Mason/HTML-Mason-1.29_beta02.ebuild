# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Mason/HTML-Mason-1.29_beta02.ebuild,v 1.1 2005/08/08 10:09:16 mcummings Exp $

inherit perl-module

MY_P=${P/beta/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A HTML development and delivery Perl Module"
SRC_URI="mirror://cpan/authors/id/D/DR/DROLSKY/${MY_P}.tar.gz"
HOMEPAGE="http://www.masonhq.com/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"
IUSE="apache2 modperl"
SRC_TEST="do"

DEPEND="${DEPEND}
	|| ( perl-core/CGI
		modperl?
			(
			!apache2? ( =net-www/apache-1* >=www-apache/libapreq-1.0-r2 )
			apache2? ( >=net-www/apache-2 www-apache/libapreq2 )
			)
		)
	>=dev-perl/Params-Validate-0.24-r2
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

	perlinfo

	export PERL_MM_USE_DEFAULT=1


	SRC_PREP="yes"
	einfo "Using Module::Build"
	if [ -z ${BUILDER_VER} ]; then
		eerror
		eerror "Please post a bug on http://bugs.gentoo.org assigned to"
		eerror "perl@gentoo.org - ${P} was added without a dependancy"
		eerror "on dev-perl/module-build"
		eerror "${BUILDER_VER}"
		eerror
		die
	else
		APACHE="${APACHE}" perl ${S}/Build.PL installdirs=vendor destdir=${D} ${myconf}
	fi
}

src_install () {
	# rendhalver - these bits arent needed for this version
	#This is a nasty fix for a sandbox violation that Mason wants to do
	#mv -f install/delete_old_pods.pl install/delete_old_pods.pl2
	#sed -e "s/use strict/exit()/" install/delete_old_pods.pl2 > install/delete_old_pods.pl

	perl-module_src_install
	# rendhalver - the html docs have subdirs so this gets all of them
	dohtml -r htdocs/*
}


pkg_postinst() {
	# rendhalver - and we can probably turn this off now
	# but i am not sure which version of Mason did this.

	einfo
	einfo "Due to a change in documention in HTML-Mason, you will need to note"
	einfo "that the documentation in the following files is no longer valid."
	einfo "These files are present only if you had a previous install of "
	einfo "HTML-Mason. Feel free to remove these docs from your system: "
	einfo "/usr/lib/perl5/site_perl/PERLVERSION/HTML/Mason/Interp.pod"
	einfo "/usr/lib/perl5/site_perl/PERLVERSION/HTML/Mason/ApacheHandler.pod"
	einfo "/usr/lib/perl5/site_perl/PERLVERSION/HTML/Mason/Request.pod"
	einfo "/usr/lib/perl5/site_perl/PERLVERSION/HTML/Mason/Component.pod"
	einfo "Where PERLVERSION is your version of perl (5.6.1, 5.8)"
	einfo

}
