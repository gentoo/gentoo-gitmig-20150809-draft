# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/actionwebservice/actionwebservice-0.8.1.ebuild,v 1.3 2005/07/27 13:07:37 caleb Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="Simple Support for Web Services APIs for Rails"
HOMEPAGE="http://rubyforge.org/projects/aws/"
# The URL depends implicitly on the version, unfortunately. Even if you
# change the filename on the end, it still downloads the same file.
SRC_URI="http://rubyforge.org/frs/download.php/5172/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.2
	>=dev-ruby/actionpack-1.9.1
	>=dev-ruby/activerecord-1.11.1
	>=dev-ruby/activesupport-1.1.1"
