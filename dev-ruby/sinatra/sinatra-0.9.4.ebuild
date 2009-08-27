# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sinatra/sinatra-0.9.4.ebuild,v 1.2 2009/08/27 08:39:47 a3li Exp $

inherit ruby gems
USE_RUBY="ruby18"

DESCRIPTION="Sinatra is a DSL for quickly creating web applications in Ruby with minimal effort."
HOMEPAGE="http://www.sinatrarb.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.6
	>=dev-ruby/rack-0.9.1"
RDEPEND="${DEPEND}"
