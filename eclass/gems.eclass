# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/gems.eclass,v 1.2 2005/03/31 00:30:02 pythonhead Exp $
#
# Author: Rob Cakebread <pythonhead@gentoo.org>
# Current Maintainer: Rob Cakebread <pythonhead@gentoo.org>
#
# The gems eclass is designed to allow easier installation of
# gems-based ruby packagess and their incorporation into 
# the Gentoo Linux system.
#
# - Features:
# gems_location()     - Set ${GEMSDIR} with gem install dir and ${GEM_SRC} with path to gem to install
# gems_src_install()  - installs a gem into ${D}
# gems_src_unpack()   - Does nothing.
# gems_src_compile()  - Does nothing.
#
# NOTE:
# See http://dev.gentoo.org/~pythonhead/ruby/gems.html for notes on using gems with portage


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

	if [ -z "${MY_P}" ]; then
		GEM_SRC=${DISTDIR}/${P}
		einfo ${GEM_SRC}
	else
		GEM_SRC=${DISTDIR}/${MY_P}
		einfo ${GEM_SRC}
	fi

	dodir ${GEMSDIR}
	gem install ${GEM_SRC} -v ${PV} -l -i ${D}/${GEMSDIR} || die "gem install failed"
	
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


EXPORT_FUNCTIONS src_unpack src_compile src_install

