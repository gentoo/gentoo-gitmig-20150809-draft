# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxsession-lite/lxsession-lite-0.3.6.ebuild,v 1.3 2009/03/24 21:53:36 yngwin Exp $

EAPI="2"

DESCRIPTION="LXDE session manager (lite version)"
HOMEPAGE="http://lxde.sf.net/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="+hal"

RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:2
	hal? ( sys-apps/hal )
	!lxde-base/lxsession"
DEPEND="${REPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_configure() {
	econf $(use_enable hal)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README || die "dodoc failed"
}
