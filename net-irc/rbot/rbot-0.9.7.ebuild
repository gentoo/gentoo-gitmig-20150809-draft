# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/rbot/rbot-0.9.7.ebuild,v 1.4 2005/04/22 15:08:20 swegener Exp $

DESCRIPTION="rbot is a ruby IRC bot"
HOMEPAGE="http://www.linuxbrit.co.uk/rbot/"
SRC_URI="http://www.linuxbrit.co.uk/downloads/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~amd64"
IUSE="spell"

RDEPEND="virtual/ruby
	dev-ruby/ruby-bdb
	dev-ruby/rexml
	spell? ( app-text/ispell )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}

	sed -i -e s:rbotconf:/etc/rbot: ${S}/rbot.rb || die "sed failed"
}

src_install() {
	local SITERUBY="$(ruby -r rbconfig -e 'print Config::CONFIG["sitelibdir"]')"

	newbin rbot.rb rbot || die "newbin failed"

	insinto "${SITERUBY}"
	doins -r rbot || die "doins failed"

	insinto /etc/rbot
	doins rbotconf/* || die "doins failed"

	dodoc AUTHORS ChangeLog INSTALL REQUIREMENTS TODO
	dohtml -r doc/*
}

pkg_postinst() {
	einfo
	einfo "Now edit your /etc/rbot/conf.rbot"
	einfo
}
