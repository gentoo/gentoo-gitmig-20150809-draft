# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/halevt/halevt-0.1.6.2-r1.ebuild,v 1.1 2010/06/28 20:46:26 hwoarang Exp $
EAPI="2"

inherit eutils

DESCRIPTION="A daemon built on ivman that executes arbitrary commands on HAL events"
HOMEPAGE="http://www.nongnu.org/halevt/"
SRC_URI="http://savannah.nongnu.org/download/halevt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls rpath"

DEPEND="dev-libs/libxml2
	>=sys-apps/hal-0.5.11-r1
	>=sys-apps/dbus-1.2.3-r1
	>=dev-libs/dbus-glib-0.76
	>=dev-libs/boolstuff-0.1.12
	nls? ( sys-devel/gettext )"
RDEPEND="${DEPEND}"

src_prepare() {
	#hide debug message from daemon
	sed -i  "/Using configuration file/s:^://:" src/manager.c
}

src_configure() {
	econf $(use_enable nls) $(use_enable rpath)
}

src_install () {
	emake DESTDIR="${D}" install || die "install failed"
	doinitd "${FILESDIR}"/${PN} || die "failed to install init script"
	dodoc AUTHORS NEWS README || die "dodoc failed"

	insinto /usr/share/halevt/examples/
	doins examples/*.xml
	doins examples/*.sh

	insinto /etc/${PN}/
	newins examples/automatic_sync_mount.xml ${PN}.xml || die "newins ${PN}.xml failed"
}
