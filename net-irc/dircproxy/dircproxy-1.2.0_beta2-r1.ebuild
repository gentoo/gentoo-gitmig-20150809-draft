# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/dircproxy/dircproxy-1.2.0_beta2-r1.ebuild,v 1.2 2009/03/08 03:10:26 dragonheart Exp $

inherit eutils

MY_P="${P/_/-}"
DESCRIPTION="an IRC proxy server"
HOMEPAGE="http://code.google.com/p/dircproxy"
SRC_URI="http://dircproxy.googlecode.com/files/${MY_P}.tar.bz"


SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/1.2.0-CVE-2007-5226.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog FAQ NEWS README* TODO INSTALL
}
