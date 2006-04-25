# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/galago-daemon/galago-daemon-0.3.4.ebuild,v 1.3 2006/04/25 14:49:54 dertobi123 Exp $

inherit eutils autotools

DESCRIPTION="Galago presence daemon"
HOMEPAGE="http://www.galago-project.org/"
SRC_URI="http://www.galago-project.org/files/releases/source/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test"

RDEPEND=">=dev-libs/glib-2.2.2
		 >=dev-libs/libgalago-0.3.3
		 >=sys-apps/dbus-0.22"
DEPEND="${RDEPEND}
		dev-util/pkgconfig
		test? ( dev-libs/check )"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Allow disabling of tests
	epatch ${FILESDIR}/galago-daemon-0.3.4-test-option.patch

	eautoreconf
}

src_compile() {
	econf $(use_enable test tests) || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
