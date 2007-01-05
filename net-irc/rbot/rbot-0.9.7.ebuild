# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/rbot/rbot-0.9.7.ebuild,v 1.10 2007/01/05 20:45:17 flameeyes Exp $

DESCRIPTION="rbot is a ruby IRC bot"
HOMEPAGE="http://www.linuxbrit.co.uk/rbot/"
SRC_URI="http://www.linuxbrit.co.uk/downloads/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~amd64"
IUSE="doc spell"

RDEPEND=">=virtual/ruby-1.8
	dev-ruby/ruby-bdb
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
	use doc && dohtml -r doc/*
}

pkg_postinst() {
	elog
	elog "Now edit your /etc/rbot/conf.rbot"
	elog
}
