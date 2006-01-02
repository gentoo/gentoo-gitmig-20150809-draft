# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/rbot/rbot-0.9.9.ebuild,v 1.1 2006/01/02 16:06:59 swegener Exp $

inherit ruby

DESCRIPTION="rbot is a ruby IRC bot"
HOMEPAGE="http://www.linuxbrit.co.uk/rbot/"
SRC_URI="http://www.linuxbrit.co.uk/downloads/${P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="doc spell"

RDEPEND=">=virtual/ruby-1.8
	dev-ruby/ruby-bdb
	spell? ( app-text/ispell )"
DEPEND="${RDEPEND}"

src_install() {
	ruby_src_install
	sed -i -e "s:${D}:/:" "${D}"/usr/lib/ruby/site_ruby/*/rbot/pkgconfig.rb
}

pkg_postinst() {
	einfo
	einfo "Default configuration file location has changed from /etc/rbot to ~/.rbot"
	einfo
}
