# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/nitro/nitro-0.29.0.ebuild,v 1.1 2006/04/17 23:35:45 caleb Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="An engine for developing professional Web Applications in Ruby"
HOMEPAGE="http://www.nitrohq.com/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~ia64 ~x86"

IUSE="apache2 fastcgi lighttpd xslt"
DEPEND=">=dev-lang/ruby-1.8.3
	=dev-ruby/og-${PV}
	=dev-ruby/gen-${PV}
	=dev-ruby/glue-${PV}
	=dev-ruby/redcloth-3.0.3
	=dev-ruby/ruby-breakpoint-0.5.0
	=dev-ruby/daemons-0.4.2
	apache2? ( =net-www/apache-2* )
	fastcgi? ( >=dev-ruby/ruby-fcgi-0.8.5-r1 )
	lighttpd? ( >=www-servers/lighttpd-1.3.13-r3 )
	xslt? ( >=dev-ruby/ruby-xslt-0.8.1 )"
