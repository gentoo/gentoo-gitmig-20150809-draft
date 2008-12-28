# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/twitter/twitter-0.4.0.ebuild,v 1.1 2008/12/28 10:45:34 graaff Exp $

inherit gems

DESCRIPTION="Ruby wrapper around the Twitter API"
HOMEPAGE="http://twitter.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-ruby/rubygems-1.3.0
	>=dev-ruby/hpricot-0.6
	>=dev-ruby/activesupport-2.1
	>=dev-ruby/httparty-0.2.4"
