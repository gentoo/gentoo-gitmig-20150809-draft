# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/xmpp4r/xmpp4r-0.4.ebuild,v 1.1 2008/11/30 16:13:09 graaff Exp $

inherit gems

DESCRIPTION="An XMPP library for Ruby"
HOMEPAGE="http://home.gna.org/xmpp4r/"
SRC_URI="http://download.gna.org/xmpp4r/${P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="examples"

USE_RUBY="ruby18"

src_install() {
	gems_src_install
	gems_location
	D2="${D}/${GEMSDIR}/gems/${P}"
	use examples || rm -r ${D2}/data/doc/xmpp4r/examples
	mv ${D2}/data/doc/xmpp4r ${D2}/data/doc/${PF} || die "Failed to rename examples"
	dodoc ${D2}/{README.rdoc,README_ruby19.txt,CHANGELOG}
}
