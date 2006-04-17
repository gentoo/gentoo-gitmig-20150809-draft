# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/actionwebservice/actionwebservice-1.1.2.ebuild,v 1.2 2006/04/17 18:23:11 flameeyes Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="Simple Support for Web Services APIs for Rails"
HOMEPAGE="http://rubyforge.org/projects/aws/"
# The URL depends implicitly on the version, unfortunately. Even if you
# change the filename on the end, it still downloads the same file.
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="1.1"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.2
	>=dev-ruby/actionpack-1.12.1
	>=dev-ruby/activerecord-1.14.2
	>=dev-ruby/activesupport-1.3.1"
