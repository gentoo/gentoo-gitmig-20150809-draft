# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/consolekit/consolekit-0.2.0.ebuild,v 1.1 2007/03/24 17:09:06 steev Exp $

inherit eutils autotools

MY_PN="ConsoleKit"

DESCRIPTION="Framework for defining and tracking users, login sessions and seats."
HOMEPAGE="http://if.only.it.had.one"
SRC_URI="http://people.freedesktop.org/~mccann/dist/${MY_PN}-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug pam"

RDEPEND=">=dev-libs/glib-2.7
		>=dev-libs/dbus-glib-0.61
		pam? ( sys-libs/pam )"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

S="${WORKDIR}/${MY_PN}-${PV}"

src_compile() {
	econf $(use_enable debug) \
	$(use_enable pam pam-module) \
	--with-pid-file=/var/run/consolekit.pid \
	--with-dbus-services=/usr/share/dbus-1/services/ \
	|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	#crappy Redhat init script
	rm -f "${D}/etc/rc.d/init.d/ConsoleKit"
	rm -r "${D}/etc/rc.d/"

	# Gentoo style init script
	newinitd "${FILESDIR}"/${PN}-0.1.rc consolekit
}
