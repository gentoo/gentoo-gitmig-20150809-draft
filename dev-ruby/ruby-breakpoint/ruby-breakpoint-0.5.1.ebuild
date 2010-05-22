# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-breakpoint/ruby-breakpoint-0.5.1.ebuild,v 1.6 2010/05/22 15:43:28 flameeyes Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="An interactive debugging library"
HOMEPAGE="http://ruby-breakpoint.rubyforge.org"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ia64 ~ppc ~ppc64 x86"

IUSE=""
DEPEND="=dev-lang/ruby-1.8*"
