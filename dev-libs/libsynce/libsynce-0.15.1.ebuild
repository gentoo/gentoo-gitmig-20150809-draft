# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libsynce/libsynce-0.15.1.ebuild,v 1.3 2012/05/04 18:35:55 jdhore Exp $

EAPI=2

DESCRIPTION="A library for SynCE"
HOMEPAGE="http://www.synce.org/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus static-libs"

RDEPEND="dbus? ( >=dev-libs/dbus-glib-0.88 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable static-libs static) \
		--enable-dccm-file-support \
		$(use_enable dbus odccm-support) \
		--disable-hal-support \
		$(use_enable dbus udev-support)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog README TODO

	find "${D}" -name '*.la' -exec rm -f {} +
}
