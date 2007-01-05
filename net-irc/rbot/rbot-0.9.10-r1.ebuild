# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/rbot/rbot-0.9.10-r1.ebuild,v 1.2 2007/01/05 20:45:17 flameeyes Exp $

inherit ruby gems

DESCRIPTION="rbot is a ruby IRC bot"
HOMEPAGE="http://www.linuxbrit.co.uk/rbot/"

SRC_URI="http://www.linuxbrit.co.uk/downloads/${P}.gem"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="spell"

RDEPEND=">=virtual/ruby-1.8
	dev-ruby/ruby-bdb"
DEPEND="${RDEPEND}"

pkg_postinst() {
	elog
	elog "Default configuration file location has changed from /etc/rbot to ~/.rbot"
	elog
}
