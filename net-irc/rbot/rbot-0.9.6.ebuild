# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/rbot/rbot-0.9.6.ebuild,v 1.5 2004/07/15 00:48:17 agriffis Exp $

DESCRIPTION="rbot is a ruby IRC bot"
HOMEPAGE="http://www.linuxbrit.co.uk/rbot/"
SRC_URI="http://www.linuxbrit.co.uk/downloads/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="spell"

DEPEND="virtual/ruby"
RDEPEND="${DEPEND}
	dev-ruby/ruby-bdb
	dev-ruby/rexml
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
