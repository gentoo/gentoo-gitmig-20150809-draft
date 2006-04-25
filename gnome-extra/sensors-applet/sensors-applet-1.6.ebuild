# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/sensors-applet/sensors-applet-1.6.ebuild,v 1.4 2006/04/25 14:34:48 dertobi123 Exp $

inherit gnome2 eutils

DESCRIPTION="GNOME panel applet to display readings from hardware sensors"
HOMEPAGE="http://sensors-applet.sourceforge.net/"
SRC_URI="mirror://sourceforge/sensors-applet/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE="hddtemp"

RDEPEND=">=x11-libs/gtk+-2.4.0
	>=gnome-base/libgnomeui-2
	>=gnome-base/gnome-panel-2
	hddtemp? ( >=app-admin/hddtemp-0.3_beta13 )"

DEPEND="${RDEPEND} >=dev-util/pkgconfig-0.12
		>=app-text/gnome-doc-utils-0.3.2"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_compile() {
	gnome2_omf_fix help/Makefile.in
	gnome2_src_compile
}
