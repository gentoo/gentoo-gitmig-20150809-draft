# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/rbot/rbot-0.9.6.ebuild,v 1.8 2005/05/03 19:30:24 swegener Exp $

DESCRIPTION="rbot is a ruby IRC bot"
HOMEPAGE="http://www.linuxbrit.co.uk/rbot/"
SRC_URI="http://www.linuxbrit.co.uk/downloads/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="spell"

DEPEND="|| (
		>=virtual/ruby-1.8
		(
			=virtual/ruby-1.6*
			(
				dev-ruby/shim-ruby18
				dev-ruby/rexml
			)
		)
	)
	dev-ruby/ruby-bdb"

RDEPEND="${DEPEND}
	spell? ( app-text/ispell )"

src_unpack() {
	unpack ${A}

	cd ${S}
	ruby -pi -e 'sub /rbotconf/, "/etc/rbot"' ${S}/rbot.rb || die
}

src_install() {
	local SITERUBY=$(ruby -r rbconfig -e 'print Config::CONFIG["sitelibdir"]')

	newbin rbot.rb rbot

	dodir ${SITERUBY}
	cp -a rbot ${D}${SITERUBY} || die

	dodir /etc/rbot
	cp -r rbotconf/* ${D}/etc/rbot || die

	dodoc AUTHORS ChangeLog INSTALL REQUIREMENTS TODO
	dohtml -r doc/*
}

pkg_postinst() {
	einfo "Now edit your /etc/rbot/conf.rbot"
}
