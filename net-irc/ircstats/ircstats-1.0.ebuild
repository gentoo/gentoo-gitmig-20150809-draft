# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ircstats/ircstats-1.0.ebuild,v 1.1 2005/08/18 00:59:02 swegener Exp $

inherit toolchain-funcs

MY_P="IRCStats-${PV}"

DESCRIPTION="IRCStats tries to be a log analyzer for Linux similar to mIRCStats"
HOMEPAGE="http://humdi.net/ircstats/"
SRC_URI="http://humdi.net/ircstats/${MY_P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

S="${WORKDIR}"/${MY_P}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin ircstats || die "dobin failed"

	insinto /usr/share/ircstats
	doins -r html languages colors || die "doins failed"

	dodoc CHANGES README TODO ircstats.cfg || die "dodoc failed"
}

pkg_postinst() {
	einfo "The IRCStats files have been installed in /usr/share/ircstats"
	einfo "You can find an example ircstats.cfg in /usr/share/doc/${PF}"
}
