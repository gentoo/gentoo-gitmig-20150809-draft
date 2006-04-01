# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/perl-app.eclass,v 1.2 2006/04/01 15:58:29 mcummings Exp $

#
# Author: Michael Cummings <mcummings@gentoo.org>
# Maintained by the Perl herd <perl@gentoo.org>
#
# The perl-app eclass is designed to allow easier installation of perl
# apps, ineheriting the full structure of the perl-module eclass but allowing
# man3 pages to be built. This is to work around a collision-protect bug in the
# default perl-module eclass

inherit perl-module

EXPORT_FUNCTIONS src_compile

perl-app_src_prep() {

	perlinfo

	export PERL_MM_USE_DEFAULT=1


	SRC_PREP="yes"
	if [ -f ${S}/Makefile.PL ]; then
		einfo "Using ExtUtils::MakeMaker"
		#perl Makefile.PL ${myconf} \
		perl Makefile.PL ${myconf} INSTALLMAN3DIR='none'\
		PREFIX=/usr INSTALLDIRS=vendor DESTDIR=${D}
	elif [ -f ${S}/Build.PL ] && [ "${USE_BUILDER}" == "yes" ]; then
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
			perl ${S}/Build.PL installdirs=vendor destdir=${D}
		fi
	else
		einfo "No Make or Build file detect..."
		return
	fi
}

perl-app_src_compile() {

	perlinfo
	[ "${SRC_PREP}" != "yes" ] && perl-app_src_prep
	if [ -z ${BUILDER_VER} ]; then
		make ${mymake} || die "compilation failed"
	else
		perl ${S}/Build build
	fi

}
