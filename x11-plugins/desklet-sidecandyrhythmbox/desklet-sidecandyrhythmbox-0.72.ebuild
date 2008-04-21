# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-sidecandyrhythmbox/desklet-sidecandyrhythmbox-0.72.ebuild,v 1.3 2008/04/21 20:48:59 armin76 Exp $

inherit gdesklets

DESKLET_NAME="SideCandyRhythmbox"

MY_P="${DESKLET_NAME}-${PV}"
S=${WORKDIR}/${DESKLET_NAME}

DESCRIPTION="A Rhythmbox Control and Display for gDesklets"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=243"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="~ppc ~x86"

RDEPEND=">=gnome-extra/gdesklets-core-0.34.3
	media-sound/rhythmbox"
