# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxsession-lite/lxsession-lite-0.3.6.ebuild,v 1.2 2009/01/08 00:03:07 bluebird Exp $

EAPI="1"

DESCRIPTION="LXDE session manager (lite version)"
HOMEPAGE="http://lxde.sf.net/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:2
	!lxde-base/lxsession"
DEPEND="${REPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_install () {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog README
}
