# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rubypants/rubypants-0.2.0.ebuild,v 1.1 2007/04/18 11:46:14 agorf Exp $

inherit ruby gems

USE_RUBY="ruby18"

DESCRIPTION="A Ruby port of the SmartyPants PHP library."
HOMEPAGE="http://chneukirchen.org/blog/static/projects/rubypants.html"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.2"
RDEPEND="${DEPEND}"

pkg_postinst() {
	einfo "RubyPants uses an API compatible with RedCloth and BlueCloth"
}
