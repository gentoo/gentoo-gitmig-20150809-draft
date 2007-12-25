# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-sounds/asterisk-sounds-1.2.1-r1.ebuild,v 1.1 2007/12/25 22:39:28 rajiv Exp $

inherit eutils

IUSE=""

DESCRIPTION="Additional sounds for Asterisk"
HOMEPAGE="http://www.asterisk.org/"
SRC_URI="http://downloads.digium.com/pub/asterisk/releases/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"

DEPEND=">=net-misc/asterisk-1.2.0"

src_compile() {
	return
}

src_install() {
	emake DESTDIR="${D}" install || die "Make install failed"

	einfo "Removing sounds included with the stock asterisk distribution..."
	cd "${D}"/var/lib/asterisk/sounds
	rm -rf	conf-hasleft.gsm        \
			conf-leaderhasleft.gsm  \
			conf-placeintoconf.gsm  \
			conf-thereare.gsm       \
			conf-userswilljoin.gsm  \
			conf-userwilljoin.gsm   \
			conf-waitforleader.gsm  \
			hours.gsm               \
			invalid.gsm             \
			letters/                \
			minutes.gsm             \
			seconds.gsm             \
			silence/
	cd "${S}"

	dodoc README.txt sounds-extra.txt

	# fix permissions
	if has_version ">=net-misc/asterisk-1.0.5-r2"; then
		chown -R asterisk:asterisk "${D}"/var/lib/asterisk
		chmod -R u=rwX,g=rX,o=     "${D}"/var/lib/asterisk
	fi
}
