# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dbus/dbus-0.91.ebuild,v 1.3 2006/08/21 12:07:16 genstef Exp $

DESCRIPTION="Meta package for D-Bus"
HOMEPAGE="http://dbus.freedesktop.org/"

LICENSE="as-is"
SLOT="0"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"

IUSE="gtk python qt3" #perl,java,mono to come later.

RDEPEND=">=sys-apps/dbus-core-0.91
	python? ( >=dev-python/dbus-python-0.71 )
	qt3? ( >=dev-libs/dbus-qt3-old-0.70 )
	gtk? ( >=dev-libs/dbus-glib-0.71 )"
#	mono? ( >=dev-dotnet/dbus-sharp-0.63 )
#	perl? ( >=dev-perl/Net-DBus-0.33.3 )
#	java (there are 2 java packages, one for 1.4 and one for 1.5)
#	( >=dev-java/libdbus-java-0.4 ) # 1.4
#	( >=dev-java/libdbus-java-1.8 ) # 1.8

pkg_postinst() {
	elog "To start the D-Bus system-wide messagebus by default"
	elog "you should add it to the default runlevel :"
	elog "\`rc-update add dbus default\`"
	elog
	elog "Currently have it installed and running?"
	elog "Run etc-update and then run the following:"
	elog "\`/etc/init.d/dbus reload\`"
}
