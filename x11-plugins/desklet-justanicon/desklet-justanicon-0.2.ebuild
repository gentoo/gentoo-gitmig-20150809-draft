# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-justanicon/desklet-justanicon-0.2.ebuild,v 1.5 2006/10/06 13:17:30 nixnut Exp $

inherit gdesklets

DESKLET_NAME="JustAnIcon"

MY_P="${DESKLET_NAME}-${PV}"
S=${WORKDIR}/Displays/${DESKLET_NAME}

DESCRIPTION="A configurable desktop icon"
HOMEPAGE="http://www.gdesklets.org/?mod=project/uview&pid=19"
SRC_URI="http://www.gdesklets.org/projects/19/releases/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="~alpha ~ia64 ~ppc ~x86"

RDEPEND=">=gnome-extra/gdesklets-core-0.34.3"
