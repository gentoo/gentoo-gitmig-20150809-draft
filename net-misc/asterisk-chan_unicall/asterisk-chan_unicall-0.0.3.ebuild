# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-chan_unicall/asterisk-chan_unicall-0.0.3.ebuild,v 1.1 2008/12/15 12:17:40 pva Exp $

inherit eutils

# the source for this package I've took from astunicall-1.2.25-0.1.tar.gz
# With some trivial modifications it builds...
DESCRIPTION="Asterisk channel plugin for UniCall"
HOMEPAGE="http://www.moythreads.com/astunicall/"

SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

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
	make DESTDIR="${D}" install || die "Install failed"

	# fix permissions
	if [[ -n "$(egetent group asterisk)" ]]; then
		chown -R root:asterisk "${D}"/etc/asterisk/unicall.conf
		chmod -R u=rwX,g=rX,o= "${D}"/etc/asterisk/unicall.conf
	fi
}
