# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/actionwebservice/actionwebservice-0.6.0.ebuild,v 1.1 2005/03/11 02:34:37 pythonhead Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="Simple Support for Web Services APIs for Rails"
HOMEPAGE="http://rubyforge.org/projects/aws/"
# The URL depends implicitly on the version, unfortunately. Even if you
# change the filename on the end, it still downloads the same file.
SRC_URI="http://rubyforge.org/frs/download.php/3335/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND="=dev-lang/ruby-1.8*
		>=dev-ruby/activerecord-1.8.0
		>=dev-ruby/activesupport-1.0.1"
