# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/gnome-nettool/gnome-nettool-2.14.2.ebuild,v 1.10 2006/10/20 23:06:14 agriffis Exp $

inherit gnome2

DESCRIPTION="Collection of network tools"
HOMEPAGE="http://www.gnome.org/projects/gnome-network/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.5.4
	>=gnome-base/libglade-2
	>=gnome-base/gconf-2
	net-misc/iputils
	sys-apps/net-tools
	net-misc/whois
	net-analyzer/traceroute
	net-misc/netkit-fingerd
	app-admin/gnome-system-tools
	net-dns/bind-tools"

DEPEND=">=x11-libs/gtk+-2.5.4
	>=gnome-base/libglade-2
	>=gnome-base/gconf-2
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS ChangeLog NEWS README TODO"
