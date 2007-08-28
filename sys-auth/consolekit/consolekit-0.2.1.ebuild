# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/consolekit/consolekit-0.2.1.ebuild,v 1.13 2007/08/28 19:25:58 jer Exp $

inherit eutils autotools multilib

MY_PN="ConsoleKit"

DESCRIPTION="Framework for defining and tracking users, login sessions and seats."
HOMEPAGE="http://if.only.it.had.one"
SRC_URI="http://people.freedesktop.org/~mccann/dist/${MY_PN}-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 sh sparc x86"
IUSE="debug pam"

# Not parallel make safe
MAKEOPTS="$MAKEOPTS -j1"

RDEPEND=">=dev-libs/glib-2.7
		>=dev-libs/dbus-glib-0.61
		>=x11-libs/libX11-1.0.0
		pam? ( virtual/pam )"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

S="${WORKDIR}/${MY_PN}-${PV}"

src_compile() {
	econf $(use_enable debug) \
	$(use_enable pam pam-module) \
	--with-pam-module-dir=/$(get_libdir)/security \
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

	#Portage barfs on .la files
	rm -f "${D}/$(get_libdir)/security/pam_ck_connector.la"

	# Gentoo style init script
	newinitd "${FILESDIR}"/${PN}-0.1.rc consolekit
}

pkg_postinst() {
	ewarn
	ewarn "You need to restart ConsoleKit to get the new features."
	ewarn "This can be done with /etc/init.d/consolekit restart"
	ewarn "but make sure you do this and then restart your session"
	ewarn "otherwise you will get access denied for certain actions"
	ewarn
}
