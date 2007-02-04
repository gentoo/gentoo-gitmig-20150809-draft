# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/radius/radius-0.5.1.ebuild,v 1.1 2007/02/04 07:29:54 pclouds Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="Powerful tag-based template system."
HOMEPAGE="http://radius.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RESTRICT="test"

DEPEND=">=dev-lang/ruby-1.8.4"
