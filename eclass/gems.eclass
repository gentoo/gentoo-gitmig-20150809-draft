# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/gems.eclass,v 1.1 2005/02/16 05:26:17 pythonhead Exp $
#
# Author: Rob Cakebread <pythonhead@gentoo.org>
# Current Maintainer: Rob Cakebread <pythonhead@gentoo.org>
#
# The gems eclass is designed to allow easier installation of
# gems-based ruby packagess and their incorporation into 
# the Gentoo Linux system.
#
# - Features:
# gems_location()     - Set ${GEMSDIR} with /usr/lib/ruby/gems/RUBY_MAJ_VER
# gems_src_install()  - installs a gem into ${D}
# gems_src_test()     - unpacks gem and runs rake if there is an appropriate test dir


inherit ruby eutils

ECLASS=gems
INHERITED="$INHERITED $ECLASS"

DEPEND=">=dev-ruby/rubygems-0.8.4-r1"

S=${WORKDIR}


gems_location() {
	local sitelibdir
	sitelibdir=`ruby -r rbconfig -e 'print Config::CONFIG["sitelibdir"]'`
	export GEMSDIR=${sitelibdir/site_ruby/gems}
}


gems_src_unpack() {
	true
}


gems_src_install() {
	gems_location
	dodir ${GEMSDIR}
	gem install ${DISTDIR}/${P} -v ${PV} -l -i ${D}/${GEMSDIR} || die "gem install failed"
	
	if [ -d ${D}/${GEMSDIR}/bin ] ; then 
		exeinto /usr/bin
		for exe in ${D}/${GEMSDIR}/bin/* ; do
			doexe ${exe}
		done
	fi
}

gems_src_compile() {
	true
}

gems_src_test() {
	if has_version 'dev-ruby/rake' ; then
		cd ${WORKDIR}
		tar xf ${DISTDIR}/${P}.gem >/dev/null 2>&1
		tar xzf data.tar.gz >/dev/null 2>&1
		if [ -d ${WORKDIR}/test ] ; then
			cd ${WORKDIR}/test
			rake
		fi
	else
		einfo "You need dev-ruby/rake emerged to run this test"
	fi
}


EXPORT_FUNCTIONS src_unpack src_compile src_install src_test

