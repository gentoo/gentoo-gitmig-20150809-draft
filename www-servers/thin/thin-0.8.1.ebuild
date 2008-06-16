# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/thin/thin-0.8.1.ebuild,v 1.1 2008/06/16 19:32:57 robbat2 Exp $

inherit gems

DESCRIPTION="A fast and very simple Ruby web server"
HOMEPAGE="http://code.macournoyer.com/thin/"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

USE_RUBY="any"
DEPEND=">=dev-ruby/daemons-1.0.9
		>=dev-ruby/rack-0.2.0
		>=dev-ruby/eventmachine-0.10.0"
