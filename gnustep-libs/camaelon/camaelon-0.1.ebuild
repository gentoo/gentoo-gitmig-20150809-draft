# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/camaelon/camaelon-0.1.ebuild,v 1.4 2004/10/31 12:01:43 kloeri Exp $

inherit gnustep

S=${WORKDIR}/${PN/c/C}

DESCRIPTION="Camaelon allows you to load theme bundles for GNUstep."

HOMEPAGE="http://www.roard.com/camaelon/"
SRC_URI="http://www.roard.com/camaelon/download/${P/c/C}.tgz"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
SLOT="0"
LICENSE="LGPL-2.1"

IUSE="${IUSE}"
DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}"

