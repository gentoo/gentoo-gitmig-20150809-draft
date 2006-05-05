# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/perl-app.eclass,v 1.5 2006/05/05 13:58:54 mcummings Exp $

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
	# Disable ExtUtils::AutoInstall from prompting
	export PERL_EXTUTILS_AUTOINSTALL="--skipdeps"


	SRC_PREP="yes"
	if [ -f Makefile.PL ] && [ ! ${PN} == "module-build" ]; then
		einfo "Using ExtUtils::MakeMaker"
		#perl Makefile.PL ${myconf} \
		perl Makefile.PL ${myconf} INSTALLMAN3DIR='none'\
		PREFIX=/usr INSTALLDIRS=vendor DESTDIR=${D}
	fi
	if [ -f Build.PL ] && [ ! -f Makefile ] ; then
		einfo "Using Module::Build"
		perl Build.PL installdirs=vendor destdir=${D} libdoc=
	fi
	if [ ! -f Build.PL ] && [ ! -f Makefile.PL ]; then
		einfo "No Make or Build file detected..."
		return
	fi
}

perl-app_src_compile() {

	perlinfo
	[ "${SRC_PREP}" != "yes" ] && perl-app_src_prep
	if [ -f Makefile ]; then
		make ${mymake} || die "compilation failed"
	elif [ -f Build ]; then
		perl Build build
	fi

}
