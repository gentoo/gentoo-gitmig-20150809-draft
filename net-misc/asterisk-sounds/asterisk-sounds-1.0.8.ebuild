# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-sounds/asterisk-sounds-1.0.8.ebuild,v 1.1 2005/06/25 09:53:34 stkn Exp $

IUSE=""

DESCRIPTION="Additional sounds for Asterisk"
HOMEPAGE="http://www.asterisk.org/"
SRC_URI="ftp://ftp.asterisk.org/pub/telephony/asterisk/${P}.tar.gz"

S=${WORKDIR}/${P}

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~hppa ~amd64 ~ppc"

DEPEND="net-misc/asterisk"

src_install() {
	make DESTDIR=${D} install || die "Make install failed"

	dodoc README.txt sounds-extra.txt

	# fix permissions
	if has_version ">=net-misc/asterisk-1.0.5-r2"; then
		chown -R asterisk:asterisk ${D}/var/lib/asterisk
		chmod -R u=rwX,g=rX,o=     ${D}/var/lib/asterisk
	fi
}
