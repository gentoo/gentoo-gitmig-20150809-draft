# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/shorturl/shorturl-0.8.7.ebuild,v 1.1 2009/11/28 10:42:42 a3li Exp $

inherit ruby gems

DESCRIPTION="A very simple library to use URL shortening services such as TinyURL or RubyURL."
HOMEPAGE="http://shorturl.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

USE_RUBY="ruby18" 
DEPEND="virtual/ruby"
