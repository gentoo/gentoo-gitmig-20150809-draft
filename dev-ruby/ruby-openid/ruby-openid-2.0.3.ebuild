# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-openid/ruby-openid-2.0.3.ebuild,v 1.1 2008/01/26 07:44:28 graaff Exp $

inherit gems

DESCRIPTION="A robust library for verifying and serving OpenID identities"
HOMEPAGE="http://ruby-openid.rubyforge.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~amd64 ~x86"
IUSE=""

pkg_postinst() {
	ewarn "Note that the API has changed from ruby-openid-1.x.x"
	ewarn "More information can be found in the file UPGRADE"
}
