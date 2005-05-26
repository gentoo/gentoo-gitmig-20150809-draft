# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-scweather/desklet-scweather-0.1-r1.ebuild,v 1.1 2005/05/26 03:27:16 nixphoeni Exp $

inherit gdesklets

DESKLET_NAME="SC-Weather"

MY_P="${DESKLET_NAME}-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A weather display using SideCandy for gDesklets"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=244"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="~x86"

RDEPEND=">=gnome-extra/gdesklets-core-0.34.3"

DOCS="README"

src_unpack ()
{

	unpack ${A}

	mkdir ${S}/controls/IYahooWeather
	mv ${S}/controls/*.py ${S}/controls/IYahooWeather/

	# Fix the SideCandy issue in >0.35
	sed -i -e "s:<group id=\"slider\":<group id=\"slider\" width=\"5cm\":" ${S}/${DESKLET_NAME}/sc-weather.display

}
