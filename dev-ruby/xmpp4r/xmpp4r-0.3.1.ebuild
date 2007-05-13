# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/xmpp4r/xmpp4r-0.3.1.ebuild,v 1.1 2007/05/13 16:07:24 graaff Exp $

RUBY_BUG_145222=yes
inherit ruby gems

DESCRIPTION="An XMPP library for Ruby"
HOMEPAGE="http://home.gna.org/xmpp4r/"
SRC_URI="http://download.gna.org/xmpp4r/${P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~ppc64"
IUSE="examples"

DEPEND=">=dev-lang/ruby-1.8"

src_install() {
	gems_src_install
	gems_location
	D2="${D}/${GEMSDIR}/gems/${P}"
	use examples || rm -r ${D2}/data/doc/xmpp4r/examples
	mv ${D2}/data/doc/xmpp4r ${D2}/data/doc/${PF} || die "Failed to rename examples"
	dodoc ${D2}/{UPDATING,LICENSE,COPYING,README,ChangeLog}
}
