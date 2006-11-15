# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wininfo/wininfo-0.7.ebuild,v 1.12 2006/11/15 20:50:26 nelchael Exp $

DESCRIPTION="An X app that follows your pointer providing information about the windows below"
HOMEPAGE="http://freedesktop.org/Software/wininfo"
SRC_URI="http://www.freedesktop.org/software/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	x11-libs/libXres
	x11-libs/libXext"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ABOUT-NLS AUTHORS NEWS README
}
