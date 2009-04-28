# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-ftb/desklet-ftb-0.3.2.ebuild,v 1.8 2009/04/28 01:29:22 nixphoeni Exp $

DESKLET_NAME="FTB"

inherit gdesklets

S="${WORKDIR}/Displays/${DESKLET_NAME}"

DESCRIPTION="Configurable, stackable system monitors"
HOMEPAGE="http://www.gdesklets.org/?mod=project/releases&pid=16"
SRC_URI="http://www.gdesklets.org/projects/16/releases/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="alpha ~amd64 ia64 ppc ~x86"
