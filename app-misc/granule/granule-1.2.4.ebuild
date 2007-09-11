# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/granule/granule-1.2.4.ebuild,v 1.1 2007/09/11 19:13:58 angelos Exp $

DESCRIPTION="flashcard program that implements Leitner cardfile methodology"
HOMEPAGE="http://granule.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-cpp/gtkmm-2.4.1
	>=dev-cpp/libassa-3.4.2
	x11-libs/gtk+
	dev-cpp/glibmm
	>=dev-libs/libsigc++-2.0
	x11-libs/pango
	dev-libs/glib
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
