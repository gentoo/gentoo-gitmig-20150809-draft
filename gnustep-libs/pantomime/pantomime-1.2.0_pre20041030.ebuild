# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/pantomime/pantomime-1.2.0_pre20041030.ebuild,v 1.1 2004/10/31 17:08:12 fafhrd Exp $

ECVS_CVS_COMMAND="cvs -q"
ECVS_SERVER="Sophos.ca:/opt/cvsroot"
ECVS_USER="anoncvs"
ECVS_PASS="anoncvs"
ECVS_AUTH="pserver"
ECVS_MODULE="${PN/p/P}"
ECVS_CO_OPTS="-P -D ${PV/*_pre}"
ECVS_UP_OPTS="-dP -D ${PV/*_pre}"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/Sophos.ca-collaborationworld"
inherit gnustep cvs

S=${WORKDIR}/${ECVS_MODULE}

DESCRIPTION="A set of Objective-C classes that model a mail system."
HOMEPAGE="http://www.collaboration-world.com/pantomime/"

LICENSE="LGPL-2.1 Elm"
KEYWORDS="~ppc"
SLOT="0"

IUSE="${IUSE}"
DEPEND="${GS_DEPEND}
	dev-libs/openssl"
RDEPEND="${GS_RDEPEND}
	dev-libs/openssl"

