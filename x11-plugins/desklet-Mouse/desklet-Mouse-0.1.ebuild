# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-Mouse/desklet-Mouse-0.1.ebuild,v 1.2 2009/11/24 13:05:29 nixphoeni Exp $

CONTROL_NAME="${PN#desklet-}"
# This only needs to stick around until the new eclass is committed
DESKLET_NAME="${PN#desklet-}"

inherit gdesklets

DESCRIPTION="Control for gDesklets that reports information about the cursor"
HOMEPAGE="http://gdesklets.de/?q=control/view/101"
LICENSE="GPL-2"
# This also only needs to stick around until the new eclass is committed
SRC_URI="${SRC_URI/\/desklets//controls}"

SLOT="0"
IUSE=""
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
