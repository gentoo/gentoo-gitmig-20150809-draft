# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/prefsmodule/prefsmodule-1.1.1_pre20040909.ebuild,v 1.1 2004/09/25 22:26:54 fafhrd Exp $

inherit gnustep

S=${WORKDIR}/Backbone/System/Frameworks/${PN/prefsm/PrefsM}

DESCRIPTION="Preferences is the GNUstep program with which you define your own personal user experience."
HOMEPAGE="http://www.nongnu.org/backbone/apps.html"
SRC_URI="mirror://gentoo/Backbone-cvs-${PV/1.1.1_pre/}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

IUSE="${IUSE}"
DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}"

