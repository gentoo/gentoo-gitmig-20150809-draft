# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/radiant/radiant-0.6.2.ebuild,v 1.1 2007/07/08 15:36:13 graaff Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="A no-fluff, open source content management system"
HOMEPAGE="http://radiantcms.org/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.4
	>=dev-ruby/rake-0.7.1"

pkg_postinst() {
	ewarn "Upgrading from radiant 0.5.x to 0.6.x may not be seamless"
	ewarn "especially if you have developed your own plugins"
	ewarn "To find out more about the upgrading procedures see"
	ewarn "http://dev.radiantcms.org/radiant/wiki/HowToUpgrade05xTo06"
	ewarn ""
	ewarn "More information including instructions to move from plugins"
	ewarn "to extensions can be found here:"
	ewarn "http://seancribbs.com/tech/2007/04/18/whats-new-in-radiant-0-6/"
}
