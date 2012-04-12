# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/rtl-sdr/rtl-sdr-9999.ebuild,v 1.1 2012/04/12 23:40:25 chithanh Exp $

EAPI=4
inherit autotools git-2

DESCRIPTION="turns your Realtek RTL2832 based DVB dongle into a SDR receiver"
HOMEPAGE="http://sdr.osmocom.org/trac/wiki/rtl-sdr"
SRC_URI=""
EGIT_REPO_URI="git://git.osmocom.org/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="virtual/libusb:1"
DEPEND="${RDEPEND}"

src_prepare() {
	eautoreconf
}
