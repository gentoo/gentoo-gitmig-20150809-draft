# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/textedit/textedit-0.95_pre20040909.ebuild,v 1.1 2004/09/24 01:08:30 fafhrd Exp $

inherit gnustep

S=${WORKDIR}/Backbone/System/Applications/${PN/texte/TextE}

DESCRIPTION="A text editor with font, color, and style capabilities for GNUstep"
HOMEPAGE="http://www.nongnu.org/terminal/"
SRC_URI="mirror://gentoo/Backbone-cvs-${PV/0.95_pre/}.tar.gz"
KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

IUSE="${IUSE}"
DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}"

