# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/bnc/bnc-2.9.3-r2.ebuild,v 1.1 2005/04/03 21:41:12 swegener Exp $

inherit eutils

MY_P=${P/-/}
DESCRIPTION="BNC (BouNCe) is used as a gateway to an IRC Server"
HOMEPAGE="http://gotbnc.com/"
SRC_URI="http://gotbnc.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ppc ~sparc ~x86"
IUSE="ssl"

DEPEND="virtual/libc
	ssl? ( dev-libs/openssl )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	sed -i -e s:./mkpasswd:/usr/bin/bncmkpasswd: ${S}/bncsetup || die
}

src_compile() {
	econf $(use_with ssl) || die "econf failed"
	emake CFLAGS="${CFLAGS}" || die "emake failed"
	mv mkpasswd bncmkpasswd
}

src_install() {
	dobin bnc bncchk bncsetup bncmkpasswd || die "dobin failed"
	dodoc ChangeLog README example.conf motd
}

pkg_postinst() {
	einfo "You can find an example motd/conf file here:"
	einfo " /usr/share/doc/${PF}/{example.conf,motd}.gz"
}
