# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mime-types/mime-types-1.15.ebuild,v 1.4 2010/05/22 15:24:24 flameeyes Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="Provides a mailcap-like MIME Content-Type lookup for Ruby."
HOMEPAGE="http://rubyforge.org/projects/mime-types"

LICENSE="Ruby Artistic GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ppc64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.2"
RDEPEND=${DEPEND}
