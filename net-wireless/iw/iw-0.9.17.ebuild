# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/iw/iw-0.9.17.ebuild,v 1.8 2012/05/04 06:41:54 jdhore Exp $

EAPI="1"

inherit toolchain-funcs

DESCRIPTION="nl80211-based configuration utility for wireless devices using the mac80211 kernel stack"
HOMEPAGE="http://wireless.kernel.org/en/users/Documentation/iw"
SRC_URI="http://wireless.kernel.org/download/${PN}/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 arm ppc x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="dev-libs/libnl:1.1"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

CC=$(tc-getCC)
LD=$(tc-getLD)

src_install() {
	emake install DESTDIR="${D}" || die "Failed to install"
}
