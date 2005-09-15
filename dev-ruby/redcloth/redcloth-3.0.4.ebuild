# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/redcloth/redcloth-3.0.4.ebuild,v 1.1 2005/09/15 17:05:27 citizen428 Exp $

inherit ruby gems

MY_P="RedCloth-${PV}"
DESCRIPTION="A module for using Textile in Ruby"
HOMEPAGE="http://www.whytheluckystiff.net/ruby/redcloth/"
SRC_URI="http://gems.rubyforge.org/gems/${MY_P}.gem"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

USE_RUBY="any"
DEPEND="virtual/ruby"

S=${WORKDIR}/${MY_P}


pkg_postinst() {
	einfo "NOTE: This package is now installed via a 'gem'."
	einfo "Previous versions used a standard tarball."
	einfo "No packages in portage required ${PN}, so you won't be affected unless"
	einfo "you have written ruby code which requires ${PN}. In that case you'll need"
	einfo "to add this:"
	einfo
	einfo "require 'rubygems'"
	einfo
	einfo "before:"
	einfo "require '${PN}'"
}

