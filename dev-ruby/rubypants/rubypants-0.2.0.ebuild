# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rubypants/rubypants-0.2.0.ebuild,v 1.5 2010/05/22 15:52:00 flameeyes Exp $

inherit ruby gems

USE_RUBY="ruby18"

DESCRIPTION="A Ruby port of the SmartyPants PHP library."
HOMEPAGE="http://chneukirchen.org/blog/static/projects/rubypants.html"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.2"
RDEPEND="${DEPEND}"

pkg_postinst() {
	elog "RubyPants uses an API compatible with RedCloth and BlueCloth"
}
