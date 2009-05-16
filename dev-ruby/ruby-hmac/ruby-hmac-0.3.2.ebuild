# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-hmac/ruby-hmac-0.3.2.ebuild,v 1.1 2009/05/16 09:58:37 graaff Exp $

inherit gems

DESCRIPTION="A common interface to HMAC functionality as documented in RFC2104."
HOMEPAGE="http://ruby-hmac.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

USE_RUBY="ruby18"

DEPEND=">=dev-ruby/rubygems-1.3.0"
