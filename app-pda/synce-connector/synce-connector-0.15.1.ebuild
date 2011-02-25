# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-connector/synce-connector-0.15.1.ebuild,v 1.1 2011/02/25 15:27:53 ssuominen Exp $

EAPI=3

PYTHON_DEPEND="2:2.6"

inherit python

DESCRIPTION="A connection framework for SynCE"
HOMEPAGE="http://www.synce.org/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# configure.ac, AC_PATH_PROG:
# net-tools -> ifconfig
# ppp _> pppd
RDEPEND=">=dev-libs/dbus-glib-0.88
	>=dev-libs/glib-2.7
	>=dev-libs/libsynce-0.15.1[dbus]
	>=net-libs/gnet-2
	sys-fs/udev[extras]"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# configure.ac, AC_PATH_PROG:
	sed -i -e 's:dhclient:true:' configure || die

	python_convert_shebangs -r 2 .
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--enable-udev \
		--enable-bluetooth-support
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO
}
