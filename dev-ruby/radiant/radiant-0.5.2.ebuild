# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/radiant/radiant-0.5.2.ebuild,v 1.1 2007/02/04 07:34:22 pclouds Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="A no-fluff, open source content management system"
HOMEPAGE="http://radiantcms.org/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="test"

DEPEND=">=dev-lang/ruby-1.8.4
	=dev-ruby/rails-1.1.6*
	dev-ruby/bluecloth
	dev-ruby/redcloth
	dev-ruby/radius
	dev-ruby/rmagick"
