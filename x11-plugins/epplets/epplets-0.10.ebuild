# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/epplets/epplets-0.10.ebuild,v 1.4 2010/09/16 17:37:29 scarabeus Exp $

DESCRIPTION="Base files for Enlightenment epplets and some epplets"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://sourceforge/enlightenment/epplets-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE="esd"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	media-libs/freeglut
	esd? ( media-sound/esound )
	media-libs/imlib2
	>=x11-wm/enlightenment-0.16.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-proto/xproto
	x11-proto/xextproto"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog
}
