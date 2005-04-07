# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/xdcc-fetch/xdcc-fetch-1.409.ebuild,v 1.1 2005/04/07 20:32:25 swegener Exp $

inherit eutils

MY_PN="XDCC-Fetch"

DESCRIPTION="A tool for search, collecting, and downloading XDCC announcements within IRC channels, written in Ruby."
HOMEPAGE="http://xdccfetch.sourceforge.net/"
SRC_URI="mirror://sourceforge/xdccfetch/${MY_PN}-${PV}.tar.gz"
LICENSE="BSD"

SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND=">=dev-lang/ruby-1.8
	>=dev-ruby/fxruby-1.2"

S=${WORKDIR}/${MY_PN}

src_install() {
	exeinto /usr/share/${PN}
	doexe ${MY_PN}.rbw || die "doexe failed"

	make_wrapper ${PN} /usr/share/${PN}/${MY_PN}.rbw .

	insinto /usr/share/${PN}
	doins -r icons src || die "doins failed"

	dodoc COPYING || die "dodoc failed"
	dohtml doc/* || die "dohtml failed"
}
