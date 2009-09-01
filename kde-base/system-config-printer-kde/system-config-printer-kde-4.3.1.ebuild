# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/system-config-printer-kde/system-config-printer-kde-4.3.1.ebuild,v 1.1 2009/09/01 16:31:13 tampakrap Exp $

EAPI="2"

KMNAME="kdeadmin"
inherit kde4-meta python

DESCRIPTION="KDE port of Red Hat's Gnome system-config-printer"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

DEPEND="
	>=app-admin/system-config-printer-common-1.1.12
	>=dev-python/pycups-1.9.46
	>=kde-base/pykde4-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}
	net-print/cups[dbus]
"
