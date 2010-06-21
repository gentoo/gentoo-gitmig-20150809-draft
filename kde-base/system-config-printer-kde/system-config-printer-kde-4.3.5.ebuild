# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/system-config-printer-kde/system-config-printer-kde-4.3.5.ebuild,v 1.2 2010/06/21 15:53:52 scarabeus Exp $

EAPI="2"

KMNAME="kdeadmin"
inherit kde4-meta python

DESCRIPTION="KDE port of Red Hat's Gnome system-config-printer"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="
	>=app-admin/system-config-printer-common-1.1.12
	>=dev-python/pycups-1.9.46
	$(add_kdebase_dep pykde4)
"
RDEPEND="${DEPEND}
	net-print/cups[dbus]
"
