# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxappearance/lxappearance-0.5.1.ebuild,v 1.6 2012/06/05 00:30:29 xmw Exp $

EAPI="4"

DESCRIPTION="LXDE GTK+ theme switcher"
HOMEPAGE="http://lxde.sourceforge.net"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 arm ppc x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

src_configure() {
	econf --disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS
}
