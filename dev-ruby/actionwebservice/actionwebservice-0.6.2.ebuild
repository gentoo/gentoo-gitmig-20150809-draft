# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/actionwebservice/actionwebservice-0.6.2.ebuild,v 1.2 2005/04/01 18:13:26 caleb Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="Simple Support for Web Services APIs for Rails"
HOMEPAGE="http://rubyforge.org/projects/aws/"
# The URL depends implicitly on the version, unfortunately. Even if you
# change the filename on the end, it still downloads the same file.
SRC_URI="http://rubyforge.org/frs/download.php/3689/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86"

IUSE=""
DEPEND="=dev-lang/ruby-1.8*
		>=dev-ruby/actionpack-1.7.0
		>=dev-ruby/activerecord-1.9.1
		>=dev-ruby/activesupport-1.0.3"
