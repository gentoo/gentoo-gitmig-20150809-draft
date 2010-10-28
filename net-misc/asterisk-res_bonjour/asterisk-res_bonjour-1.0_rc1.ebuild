# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-res_bonjour/asterisk-res_bonjour-1.0_rc1.ebuild,v 1.3 2010/10/28 10:46:25 ssuominen Exp $

inherit eutils

MY_PN="res_bonjour"

DESCRIPTION="Asterisk resource plugin for Apple Bonjour (aka zeroconf) support"
HOMEPAGE="http://www.mezzo.net/asterisk/"
SRC_URI="http://www.mezzo.net/asterisk/${MY_PN}-${PV/_/}.tgz"

IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="net-misc/mDNSResponder
	>=net-misc/asterisk-1.0.7-r1"

S="${WORKDIR}/${MY_PN}-${PV/_/}"

src_unpack() {
	unpack ${A}

	cd "${S}"
	# use asterisk-config...
	epatch "${FILESDIR}"/${MY_PN}-1.0_rc1-astcfg.diff
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc README bonjour.conf.sample

	# fix permissions
	if [[ -n "$(egetent group asterisk)" ]]; then
		chown -R root:asterisk "${D}"etc/asterisk
		chmod -R u=rwX,g=rX,o= "${D}"etc/asterisk
	fi
}
