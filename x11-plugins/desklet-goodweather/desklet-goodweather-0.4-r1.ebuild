# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-goodweather/desklet-goodweather-0.4-r1.ebuild,v 1.2 2005/04/23 04:13:20 nixphoeni Exp $

inherit gdesklets

DESKLET_NAME="GoodWeather"
SENSOR_NAME="${DESKLET_NAME}"

MY_P=${DESKLET_NAME}
S=${WORKDIR}/${DESKLET_NAME}

DESCRIPTION="A desklet showing a weather forecast for the coming week"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.gz"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=93"
LICENSE="as-is"

SLOT="0"
IUSE=""
KEYWORDS="~x86"

RDEPEND=">=gnome-extra/gdesklets-core-0.34.3"

DOCS="README"

