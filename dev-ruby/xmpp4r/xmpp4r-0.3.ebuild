# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/xmpp4r/xmpp4r-0.3.ebuild,v 1.1 2006/12/30 03:41:08 pclouds Exp $

inherit ruby

DESCRIPTION="An XMPP library for Ruby"
HOMEPAGE="http://home.gna.org/xmpp4r/"
SRC_URI="http://download.gna.org/xmpp4r/${P}.tgz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8"

src_unpack() {
	ruby_src_unpack
	use examples || rm -r ${S}/data/doc/xmpp4r/examples
	mv ${S}/data/doc/xmpp4r ${S}/data/doc/${PF}
}
