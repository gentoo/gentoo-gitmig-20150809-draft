# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/preferences/preferences-1.3.0_pre20040909.ebuild,v 1.1 2004/09/25 22:29:44 fafhrd Exp $

inherit gnustep eutils

S=${WORKDIR}/Backbone/System/Applications/${PN/p/P}

DESCRIPTION="Preferences is the GNUstep program with which you define your own personal user experience."
HOMEPAGE="http://www.nongnu.org/backbone/apps.html"
SRC_URI="mirror://gentoo/Backbone-cvs-${PV/1.3.0_pre/}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

IUSE="${IUSE}"
DEPEND="${GS_DEPEND}
	=gnustep-libs/prefsmodule-1.1.1_pre20040909*"
RDEPEND="${GS_RDEPEND}"

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/Preferences-nocreate-extra-dirs.patch
}

