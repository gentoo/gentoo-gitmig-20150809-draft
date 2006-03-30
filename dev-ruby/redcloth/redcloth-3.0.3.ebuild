# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/redcloth/redcloth-3.0.3.ebuild,v 1.5 2006/03/30 03:42:43 agriffis Exp $

inherit ruby gems

MY_P="RedCloth-${PV}"
DESCRIPTION="A module for using Textile in Ruby"
HOMEPAGE="http://www.whytheluckystiff.net/ruby/redcloth/"
SRC_URI="http://rubyforge.org/frs/download.php/2898/${MY_P}.gem"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~ia64 x86"
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

