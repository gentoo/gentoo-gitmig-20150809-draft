# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/autossh/autossh-1.4b.ebuild,v 1.7 2011/03/30 21:20:01 radhermit Exp $

EAPI=2

DESCRIPTION="Automatically restart SSH sessions and tunnels"
HOMEPAGE="http://www.harding.motd.ca/autossh/"
SRC_URI="http://www.harding.motd.ca/${PN}/${P}.tgz"

LICENSE="BSD"
KEYWORDS="alpha amd64 ~arm ~hppa ia64 ~ppc ~sparc x86 ~amd64-linux ~ia64-linux ~x86-linux"
SLOT="0"
IUSE=""

RDEPEND="net-misc/openssh"

src_prepare() {
	sed -i -e "s:\$(CC):& \$(LDFLAGS):" Makefile.in || die
}

src_install() {
	dobin autossh
	dodoc CHANGES README autossh.host rscreen
	doman autossh.1
}
