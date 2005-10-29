# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/facets/facets-20051030.ebuild,v 1.1 2005/10/29 10:57:15 citizen428 Exp $

inherit ruby gems

IUSE=""

# upstream switched to a strange naming scheme
MY_P=$PN-${PV:0:4}"."${PV:4:2}"."${PV:6:2}

USE_RUBY="ruby18"

DESCRIPTION="Facets is an extension library adding extra functionality to Ruby"
HOMEPAGE="http://facets.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${MY_P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=dev-lang/ruby-1.8"

