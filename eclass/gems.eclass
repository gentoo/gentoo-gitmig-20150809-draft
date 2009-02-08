# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/gems.eclass,v 1.24 2009/02/08 20:48:01 a3li Exp $
#
# Author: Rob Cakebread <pythonhead@gentoo.org>
# Current Maintainer: Ruby Herd <ruby@gentoo.org>
#
# The gems eclass is designed to allow easier installation of
# gems-based ruby packagess and their incorporation into
# the Gentoo Linux system.
#
# - Features:
# gems_location()	  - Set ${GEMSDIR} with gem install dir and ${GEM_SRC} with path to gem to install
# gems_src_unpack()	  - Does nothing.
# gems_src_compile()  - Does nothing.
# gems_src_install()  - installs a gem into ${D}
#
# NOTE:
# See http://dev.gentoo.org/~pythonhead/ruby/gems.html for notes on using gems with portage


inherit eutils ruby

SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

IUSE="doc"

DEPEND="
	>=dev-ruby/rubygems-0.9.4
	!dev-ruby/rdoc
"
RDEPEND="${DEPEND}"

gems_location() {
	local sitelibdir
	sitelibdir=$(ruby -r rbconfig -e 'print Config::CONFIG["sitelibdir"]')
	export GEMSDIR=${sitelibdir/site_ruby/gems}

}

gems_src_unpack() {
	true
}

gems_src_compile() {
	true
}

gems_src_install() {
	gems_location

	if [[ -z "${MY_P}" ]]; then
		[[ -z "${GEM_SRC}" ]] && GEM_SRC="${DISTDIR}/${P}"
		spec_path="${D}/${GEMSDIR}/specifications/${P}.gemspec"
	else
		[[ -z "${GEM_SRC}" ]] && GEM_SRC="${DISTDIR}/${MY_P}"
		spec_path="${D}/${GEMSDIR}/specifications/${MY_P}.gemspec"
	fi

	local myconf
	if use doc; then
		myconf="--rdoc --ri"
	else
		myconf="--no-rdoc --no-ri"
	fi

	dodir ${GEMSDIR}

	local gte13=$(${RUBY} -rubygems -e 'puts Gem::RubyGemsVersion >= "1.3.0"')

	if [[ "${gte13}" == "true" ]] ; then
		gem install ${GEM_SRC} --version ${PV} ${myconf} \
		--local --install-dir "${D}/${GEMSDIR}" --sandbox-fix \
		|| die "gem (>=1.3.0) install failed"
	else
		gem install ${GEM_SRC} --version ${PV} ${myconf} \
		--local --install-dir "${D}/${GEMSDIR}" || die "gem (<1.3.0) install failed"
	fi

	if [[ -d "${D}/${GEMSDIR}/bin" ]] ; then
		exeinto /usr/bin
		for exe in "${D}"/${GEMSDIR}/bin/* ; do
			doexe "${exe}"
		done
	fi
}

EXPORT_FUNCTIONS src_unpack src_compile src_install
