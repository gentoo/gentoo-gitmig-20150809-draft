# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/skim/skim-0.9.3.ebuild,v 1.1 2004/07/18 10:08:39 usata Exp $

DESCRIPTION="Smart Common Input Method (SCIM) optimized for KDE"
HOMEPAGE="http://scim.freedesktop.org/Software/ScimKDE"
SRC_URI="http://freedesktop.org/~cougar/skim/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/x11
	|| ( >=app-i18n/scim-0.99.1 app-i18n/scim-cvs )
	>=x11-libs/qt-3.2.0
	>=kde-base/kdelibs-3.2.0"

src_compile() {
	addpredict /usr/qt/3/etc/settings
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog NEWS README TODO
	mv ${D}/usr/share/doc/HTML ${D}/usr/share/doc/${PF}/html
}

pkg_postinst() {
	einfo
	einfo "User manual can be found at:"
	einfo "	http://freedesktop.org/~cougar/skim/doc/user/"
	einfo
}
