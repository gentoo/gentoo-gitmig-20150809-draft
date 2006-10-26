# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-chan_unicall/asterisk-chan_unicall-0.0.3_pre9.ebuild,v 1.1 2006/10/26 18:32:24 gustavoz Exp $

inherit eutils

IUSE=""

DESCRIPTION="Asterisk channel plugin for UniCall"
HOMEPAGE="http://www.soft-switch.org/"

SRC_URI="mirror://gentoo/asterisk-chan_unicall-0.0.3_pre9.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=dev-libs/libxml2-2.6.26
	>=media-libs/libsupertone-0.0.2
	>=media-libs/spandsp-0.0.2_pre26
	>=media-libs/tiff-3.8.2-r2
	>=net-libs/libmfcr2-0.0.3
	>=net-libs/libpri-1.2
	>=net-libs/libunicall-0.0.3
	>=net-misc/asterisk-1.2
	>=net-misc/zaptel-1.2"

src_install() {
	make DESTDIR=${D} install || die "Install failed"

	# fix permissions
	if [[ -n "$(egetent group asterisk)" ]]; then
		chown -R root:asterisk "${D}"/etc/asterisk/unicall.conf
		chmod -R u=rwX,g=rX,o= "${D}"/etc/asterisk/unicall.conf
	fi
}
