# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/stshell/stshell-0.9.1.ebuild,v 1.2 2007/06/24 18:02:14 peper Exp $

inherit gnustep

DESCRIPTION="An interactive shell for StepTalk"
HOMEPAGE="http://www.gnustep.org/experience/StepTalk.html"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/libs/${P/stshell/StepTalk}.tar.gz"

# steptalk doesn't compile!
KEYWORDS=""
LICENSE="LGPL-2.1"
SLOT="0"

IUSE=""
DEPEND="${GS_DEPEND}
	=gnustep-libs/steptalk-${PV}*"
RDEPEND="${GS_RDEPEND}
	=gnustep-libs/steptalk-${PV}*"
S="${WORKDIR}/${P/stshell/StepTalk}/Examples/Shell"

egnustep_install_domain "System"
