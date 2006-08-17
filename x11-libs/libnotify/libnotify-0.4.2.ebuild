# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libnotify/libnotify-0.4.2.ebuild,v 1.9 2006/08/17 20:19:59 corsair Exp $

inherit eutils

DESCRIPTION="Notifications library"
HOMEPAGE="http://www.galago-project.org/"
SRC_URI="http://www.galago-project.org/files/releases/source/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ppc ppc64 ~sparc x86"
IUSE="doc"

RDEPEND=">=x11-libs/gtk+-2.2.2
		 >=dev-libs/glib-2.6
		 >=sys-apps/dbus-0.60
		 x11-misc/notification-daemon"
DEPEND="${RDEPEND}
		doc? ( >=dev-util/gtk-doc-1.4 )"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-0.4.2-send-uchar-array.patch
}

src_compile() {
	econf $(use_enable doc gtk-doc) || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS
}
