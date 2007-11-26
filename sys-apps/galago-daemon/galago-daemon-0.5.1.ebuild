# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/galago-daemon/galago-daemon-0.5.1.ebuild,v 1.14 2007/11/26 13:10:06 corsair Exp $

inherit eutils autotools

DESCRIPTION="Galago presence daemon"
HOMEPAGE="http://www.galago-project.org/"
SRC_URI="http://www.galago-project.org/files/releases/source/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 x86 ~x86-fbsd"
IUSE="test"

RDEPEND=">=dev-libs/glib-2.8
		 >=dev-libs/libgalago-0.5.2
		 >=dev-libs/dbus-glib-0.71"
DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.9
		test? ( dev-libs/check )"

src_compile() {
	econf $(use_enable test tests) || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
