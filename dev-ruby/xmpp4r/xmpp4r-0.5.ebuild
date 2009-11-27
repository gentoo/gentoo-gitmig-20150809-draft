# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/xmpp4r/xmpp4r-0.5.ebuild,v 1.4 2009/11/27 17:11:21 a3li Exp $

inherit gems

DESCRIPTION="An XMPP library for Ruby"
HOMEPAGE="http://home.gna.org/xmpp4r/"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
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
