# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/dbus-glib-sharp/dbus-glib-sharp-0.4.1.ebuild,v 1.1 2007/12/30 03:18:27 compnerd Exp $

inherit mono multilib

MY_PN="ndesk-dbus-glib"

DESCRIPTION="glib integration for DBus-Sharp"
HOMEPAGE="http://www.ndesk.org/DBusSharp"
SRC_URI="http://www.ndesk.org/archive/dbus-sharp/${MY_PN}-${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=dev-lang/mono-1.2.4
		 >=dev-dotnet/dbus-sharp-0.4"
DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.19"

S="${WORKDIR}/${MY_PN}-${PV}"

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
