# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/jruby-openssl/jruby-openssl-0.6.ebuild,v 1.1 2010/01/01 03:41:21 ali_bush Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="A Ruby SSL library that works with JRuby"
HOMEPAGE="http://rubyforge.org/projects/jruby-extras"
SRC_URI="mirror://rubygems/${P}.gem"

LICENSE="MIT || ( CPL-1.0 GPL-2	LGPL-2.1 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-java/jruby-1.3.1-r1"
