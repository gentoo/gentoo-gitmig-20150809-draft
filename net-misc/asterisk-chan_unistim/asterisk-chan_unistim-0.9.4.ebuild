# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-chan_unistim/asterisk-chan_unistim-0.9.4.ebuild,v 1.2 2007/01/06 16:43:26 drizzt Exp $

inherit eutils

MY_PN="chan_unistim"

DESCRIPTION="Unistim channel module for Asterisk"
HOMEPAGE="http://mlkj.net/UNISTIM/"
SRC_URI="http://mlkj.net/asterisk/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"

IUSE=""

DEPEND="!=net-misc/asterisk-1.0*
	>=net-misc/asterisk-1.2.0"

S="${WORKDIR}"/${MY_PN}-${PV}

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${MY_PN}-0.9.2-gentoo.diff
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make INSTALL_PREFIX="${D}" install config || die "make install failed"

	dodoc README unistim.conf

	# fix permissions
	if [[ -n "$(egetent group asterisk)" ]]; then
		einfo "Fixing permissions..."
		chown -R root:asterisk "${D}"etc/asterisk
		chmod -R u=rwX,g=rX,o= "${D}"etc/asterisk
	fi
}

pkg_postinst() {
	elog "For more information about this module:"
	echo
	elog "http://www.voip-info.org/wiki-Asterisk+UNISTIM+channels"
	echo
	elog "http://www.voip-info.org/wiki-Nortel+Phones"
}
