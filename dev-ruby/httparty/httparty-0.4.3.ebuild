# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/httparty/httparty-0.4.3.ebuild,v 1.2 2009/05/21 19:36:57 ranger Exp $

inherit gems

DESCRIPTION="Makes http fun! Also, makes consuming restful web services dead easy."
HOMEPAGE="http://httparty.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

USE_RUBY="ruby18"

DEPEND=">=dev-ruby/rubygems-1.3.0
	>=dev-ruby/crack-0.1.1"
