# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/terminal/terminal-0.9.5_pre20040909.ebuild,v 1.1 2004/09/24 01:07:41 fafhrd Exp $

inherit gnustep

S=${WORKDIR}/Backbone/System/Applications/${PN/t/T}

DESCRIPTION="A terminal emulator for GNUstep"
HOMEPAGE="http://www.nongnu.org/terminal/"
SRC_URI="mirror://gentoo/Backbone-cvs-${PV/0.9.5_pre/}.tar.gz"
KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

IUSE="${IUSE}"
DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}"

