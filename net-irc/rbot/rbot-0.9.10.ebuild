# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/rbot/rbot-0.9.10.ebuild,v 1.3 2007/01/05 20:45:17 flameeyes Exp $

inherit ruby

DESCRIPTION="rbot is a ruby IRC bot"
HOMEPAGE="http://www.linuxbrit.co.uk/rbot/"

if [[ ${PV} != *_pre* ]]; then
	SRC_URI="http://www.linuxbrit.co.uk/downloads/${P}.tgz"
else
	SRC_URI="mirror://gentoo/${P}.tgz"
	S="${WORKDIR}/${PN}-${PV%%_*}"
fi

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="spell"

RDEPEND=">=virtual/ruby-1.8
	dev-ruby/ruby-bdb"
DEPEND="${RDEPEND}"

src_install() {
	ruby_src_install
	sed -i -e "s:${D}:/:" "${D}"/usr/lib/ruby/site_ruby/*/rbot/pkgconfig.rb
}

pkg_postinst() {
	elog
	elog "Default configuration file location has changed from /etc/rbot to ~/.rbot"
	elog
}
