# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/granule/granule-1.4.0.ebuild,v 1.5 2011/03/27 12:02:04 nirbheek Exp $

EAPI="2"

DESCRIPTION="A flashcard program that implements Leitner cardfile methodology"
HOMEPAGE="http://granule.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-7.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-cpp/gtkmm-2.4.1:2.4
	>=dev-cpp/libassa-3.5.0
	x11-libs/gtk+:2
	dev-cpp/glibmm:2
	>=dev-libs/libsigc++-2.0
	x11-libs/pango
	dev-libs/glib:2
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool
	dev-util/pkgconfig"

S="${WORKDIR}/${P}-7"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
