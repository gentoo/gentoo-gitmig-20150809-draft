# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-newsgrab/desklet-newsgrab-1.5.ebuild,v 1.4 2006/03/24 23:07:35 agriffis Exp $

inherit gdesklets

DESKLET_NAME="NewsGrab"

S=${WORKDIR}/${DESKLET_NAME}

DESCRIPTION="News Grab is a XML rss reader that displays the titles of each news item with a small description, and the date it was posted up."
SRC_URI="http://gdesklets.gnomedesktop.org/files/${DESKLET_NAME}${PV}.tar.gz"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=209"
LICENSE="as-is"

SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"

RDEPEND=">=gnome-extra/gdesklets-core-0.34.3"
