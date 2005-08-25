# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/clipbook/clipbook-0.6.0.7.1.ebuild,v 1.3 2005/08/25 18:57:12 swegener Exp $

inherit gnustep

S=${WORKDIR}/GWorkspace-${PV/0.6.}/${PN/clipb/ClipB}

DESCRIPTION="A clipboard for GNUstep that can hold things for later copy and paste."
HOMEPAGE="http://www.gnustep.it/enrico/gworkspace/"
SRC_URI="http://www.gnustep.it/enrico/gworkspace/gworkspace-${PV/0.6.}.tar.gz"

KEYWORDS="x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"

IUSE=""
DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}"

egnustep_install_domain "System"
