# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/thin/thin-1.2.4.ebuild,v 1.1 2009/09/12 08:40:54 graaff Exp $

inherit gems

DESCRIPTION="A fast and very simple Ruby web server"
HOMEPAGE="http://code.macournoyer.com/thin/"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

# rack 0.4.0 only works with ruby18
USE_RUBY="ruby18"
DEPEND=">=dev-ruby/daemons-1.0.9
		>=dev-ruby/rack-1.0.0
		>=dev-ruby/eventmachine-0.12.6"
RDEPEND="${DEPEND}"
