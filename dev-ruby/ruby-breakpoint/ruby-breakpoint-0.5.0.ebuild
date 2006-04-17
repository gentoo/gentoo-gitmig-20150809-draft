# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-breakpoint/ruby-breakpoint-0.5.0.ebuild,v 1.4 2006/04/17 23:41:39 caleb Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="An interactive debugging library"
HOMEPAGE="http://ruby-breakpoint.rubyforge.org"
SRC_URI="http://rubyforge.org/frs/download.php/3301/${P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~ia64 ~ppc x86"

IUSE=""
DEPEND="=dev-lang/ruby-1.8*"
