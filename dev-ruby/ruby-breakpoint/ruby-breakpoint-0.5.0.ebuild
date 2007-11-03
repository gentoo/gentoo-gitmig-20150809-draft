# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-breakpoint/ruby-breakpoint-0.5.0.ebuild,v 1.8 2007/11/03 08:25:55 drac Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="An interactive debugging library"
HOMEPAGE="http://ruby-breakpoint.rubyforge.org"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ia64 ~ppc ~ppc64 x86"

IUSE=""
DEPEND="=dev-lang/ruby-1.8*"
