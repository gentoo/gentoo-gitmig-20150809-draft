# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxtask/lxtask-0.1.1.ebuild,v 1.4 2009/11/21 18:39:28 nixnut Exp $

EAPI="1"

DESCRIPTION="LXDE Task manager"
HOMEPAGE="http://lxde.sf.net/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"
SLOT="0"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	dev-libs/glib:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README || die "dodoc failed"
}
