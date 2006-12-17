# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/gnome-nettool/gnome-nettool-2.16.0.ebuild,v 1.4 2006/12/17 00:35:24 dertobi123 Exp $

inherit gnome2

DESCRIPTION="Collection of network tools"
HOMEPAGE="http://www.gnome.org/projects/gnome-network/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ppc ~ppc64 ~sparc x86"
IUSE=""

COMMON_DEPEND=">=x11-libs/gtk+-2.5.4
	>=gnome-base/libglade-2
	>=gnome-base/gconf-2"
RDEPEND="${COMMON_DEPEND}
	net-misc/iputils
	sys-apps/net-tools
	net-misc/whois
	net-analyzer/traceroute
	net-misc/netkit-fingerd
	app-admin/gnome-system-tools
	net-dns/bind-tools"

DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS ChangeLog NEWS README TODO"
