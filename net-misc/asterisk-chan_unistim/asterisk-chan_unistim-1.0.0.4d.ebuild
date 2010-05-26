# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-chan_unistim/asterisk-chan_unistim-1.0.0.4d.ebuild,v 1.2 2010/05/26 19:47:26 angelos Exp $

EAPI="2"

inherit multilib

MY_PN="chan_unistim"
MY_P=${MY_PN}-${PV}

DESCRIPTION="Unistim channel module for Asterisk"
HOMEPAGE="http://mlkj.net/UNISTIM/"
SRC_URI="http://mlkj.net/asterisk/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="=net-misc/asterisk-1.2*"
RDEPEND=${DEPEND}

S="${WORKDIR}"/${MY_P}

src_prepare() {
	# multilib support
	sed -i -e "s:/usr/lib:/usr/$(get_libdir):" Makefile || die "sed failed"
	# respect users C(XX)FLAGS
	sed -i -e "s:^CFLAGS=:CFLAGS+=:" -e "/O6/d" -e "/march/d" Makefile \
		|| die "sed failed"
	# respect users LDFLAGS
	sed -i -e "s:-shared:${LDFLAGS} -shared:" Makefile || die "sed failed"
	# better to let -pipe as user choice and add -fPIC
	sed -i -e "s:pipe:fPIC:" Makefile || die "sed failed"
}

src_install() {
	# create needed dirs
	dodir /etc/asterisk
	dodir /usr/$(get_libdir)/asterisk/modules

	emake INSTALL_PREFIX="${D}" install config || die "emake install failed"

	dodoc README CHANGES || die "dodoc failed"
}
