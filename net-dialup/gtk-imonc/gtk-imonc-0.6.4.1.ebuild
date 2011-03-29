# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/gtk-imonc/gtk-imonc-0.6.4.1.ebuild,v 1.6 2011/03/29 11:57:59 angelos Exp $

EAPI=1
inherit eutils

DESCRIPTION="A GTK+-2 based imond client for fli4l"
SRC_URI="http://userpage.fu-berlin.de/~zeank/gtk-imonc/download/${P}${V}.tar.gz"
HOMEPAGE="http://userpage.fu-berlin.de/~zeank/gtk-imonc/"

KEYWORDS="amd64 ppc x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12"

src_install() {
	make DESTDIR="${D}" install || die "install problem"
	domenu gtk-imonc.desktop
}
