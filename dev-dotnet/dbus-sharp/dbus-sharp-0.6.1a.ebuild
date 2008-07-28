# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/dbus-sharp/dbus-sharp-0.6.1a.ebuild,v 1.4 2008/07/28 15:44:49 armin76 Exp $

inherit mono

MY_PN=ndesk-dbus

DESCRIPTION="Managed D-Bus Implementation for .NET"
HOMEPAGE="http://www.ndesk.org/DBusSharp"
SRC_URI="http://www.ndesk.org/archive/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=dev-lang/mono-1.2.4
	>=sys-apps/dbus-1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_PN}-${PV}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS README
}
