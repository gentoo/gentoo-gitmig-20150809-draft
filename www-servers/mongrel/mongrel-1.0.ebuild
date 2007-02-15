# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/mongrel/mongrel-1.0.ebuild,v 1.6 2007/02/15 08:44:42 opfer Exp $

inherit ruby gems

DESCRIPTION="A small fast HTTP library and server that runs Rails, Camping, and Nitro apps"
HOMEPAGE="http://mongrel.rubyforge.org/"
SRC_URI="http://mongrel.rubyforge.org/releases/gems/${P}.gem"

LICENSE="mongrel"
SLOT="0"
KEYWORDS="~amd64 ~sparc x86 ~x86-fbsd"
IUSE=""

USE_RUBY="any"
DEPEND=">=dev-ruby/daemons-0.4.2
	>=dev-ruby/gem_plugin-0.2.1
	>=dev-ruby/fastthread-0.5.3.1
	>=dev-ruby/cgi_multipart_eof_fix-0.2.1"
