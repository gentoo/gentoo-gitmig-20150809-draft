# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxsession/lxsession-0.3.6.ebuild,v 1.1 2009/05/24 20:27:16 yngwin Exp $

EAPI="2"

MY_P="${PN}-lite-${PV}"
DESCRIPTION="LXDE session manager"
HOMEPAGE="http://lxde.sf.net/"
SRC_URI="mirror://sourceforge/lxde/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="+hal"

RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:2
	hal? ( sys-apps/hal )
	!lxde-base/lxsession-lite"
DEPEND="${REPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

S="${WORKDIR}/${MY_P}"

src_configure() {
	econf $(use_enable hal)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README || die "dodoc failed"
}
