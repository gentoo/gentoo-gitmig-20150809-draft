# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-Genesis/desklet-Genesis-0.2.ebuild,v 1.1 2009/10/27 11:26:08 nixphoeni Exp $

# This only needs to stick around until the new eclass is committed
DESKLET_NAME="${PN#desklet-}"

inherit gdesklets

DESCRIPTION="An application launcher for gDesklets"
HOMEPAGE="http://gdesklets.de/?q=desklet/view/101"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

RDEPEND=">=x11-plugins/desklet-Mouse-0.1"
