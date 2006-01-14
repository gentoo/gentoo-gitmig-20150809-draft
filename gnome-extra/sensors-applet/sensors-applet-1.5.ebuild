# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/sensors-applet/sensors-applet-1.5.ebuild,v 1.6 2006/01/14 11:00:11 dertobi123 Exp $

inherit gnome2 eutils

DESCRIPTION="GNOME panel applet to display readings from hardware sensors"
HOMEPAGE="http://sensors-applet.sourceforge.net/"
SRC_URI="mirror://sourceforge/sensors-applet/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="hddtemp"

RDEPEND=">=x11-libs/gtk+-2.4.0
	>=gnome-base/libgnomeui-2
	>=gnome-base/gnome-panel-2
	hddtemp? ( >=app-admin/hddtemp-0.3_beta13 )"

DEPEND="${RDEPEND} >=dev-util/pkgconfig-0.12"

DOCS="AUTHORS ChangeLog NEWS README TODO"

