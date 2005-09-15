# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/nitro/nitro-0.23.0.ebuild,v 1.1 2005/09/15 22:42:34 citizen428 Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="An engine for developing professional Web Applications in Ruby"
HOMEPAGE="http://www.nitrohq.com/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~x86"

IUSE="fastcgi mysql postgres sqlite xslt"
DEPEND=">=dev-lang/ruby-1.8.2
	=dev-ruby/glue-0.23.0
	=dev-ruby/og-0.23.0
	>=dev-ruby/ruby-breakpoint-0.5.0
	>=dev-ruby/redcloth-3.0.3
	fastcgi? ( >=dev-ruby/ruby-fcgi-0.8.5-r1 )
	mysql? ( >=dev-ruby/mysql-ruby-2.5 )
	postgres? ( >=dev-ruby/ruby-postgres-0.7.1 )
	sqlite? ( >=dev-ruby/sqlite-ruby-2.2.2 )
	xslt? ( >=dev-ruby/ruby-xslt-0.8.1 )"

pkg_postinst() {
	ewarn "Please note that 'nitrogen' is broken in this release of Nitro."
	ewarn "This bug is know upstream and will be fixed in the next release."
	ewarn "In the meantime you can create a new app by simply copying the"
	ewarn "the proto directory to the path were you want to create your"
	ewarn "new Nitro app."
}
