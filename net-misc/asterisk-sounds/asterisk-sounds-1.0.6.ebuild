# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-sounds/asterisk-sounds-1.0.6.ebuild,v 1.1 2005/03/10 00:56:22 stkn Exp $

IUSE=""

DESCRIPTION="Additional sounds for Asterisk"
HOMEPAGE="http://www.asterisk.org/"
SRC_URI="ftp://ftp.asterisk.org/pub/telephony/asterisk/${P}.tar.gz"

S=${WORKDIR}/${P}

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~hppa ~amd64"

DEPEND="net-misc/asterisk"

src_install() {
	emake -j1 DESTDIR=${D} install || die "Make install failed"

	dodoc README.txt sounds-extra.txt
}
