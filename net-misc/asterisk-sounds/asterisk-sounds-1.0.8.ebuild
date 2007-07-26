# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-sounds/asterisk-sounds-1.0.8.ebuild,v 1.6 2007/07/26 22:36:19 rajiv Exp $

IUSE=""

DESCRIPTION="Additional sounds for Asterisk"
HOMEPAGE="http://www.asterisk.org/"
SRC_URI="http://ftp.digium.com/pub/telephony/asterisk/old-releases/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~hppa ~amd64 ~ppc"

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
