# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-openid/ruby-openid-1.1.4.ebuild,v 1.1 2007/03/31 08:04:30 robbat2 Exp $

inherit ruby gems

DESCRIPTION="A robust library for verifying and serving OpenID identities"
HOMEPAGE="http://ruby-openid.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~amd64 ~x86"
IUSE=""

USE_RUBY="ruby18"
DEPEND=">=dev-ruby/ruby-yadis-0.3.4"
RDEPEND="${DEPEND}"
