# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/stshell/stshell-0.10.0-r1.ebuild,v 1.1 2007/09/10 18:10:54 voyageur Exp $

inherit gnustep-2

DESCRIPTION="An interactive shell for StepTalk"
HOMEPAGE="http://www.gnustep.org/experience/StepTalk.html"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/libs/${P/stshell/StepTalk}.tar.gz"

KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="LGPL-2.1"
SLOT="0"

DEPEND="~gnustep-libs/steptalk-${PV}"
RDEPEND="${DEPEND}"

S="${WORKDIR}/StepTalk/Examples/Shell"
