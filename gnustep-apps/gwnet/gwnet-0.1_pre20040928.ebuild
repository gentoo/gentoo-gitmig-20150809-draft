# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/gwnet/gwnet-0.1_pre20040928.ebuild,v 1.3 2004/11/12 03:53:47 fafhrd Exp $

ECVS_CVS_COMMAND="cvs -q"
ECVS_SERVER="savannah.gnu.org:/cvsroot/gnustep"
ECVS_USER="anoncvs"
ECVS_AUTH="ext"
ECVS_MODULE="gnustep/usr-apps/gworkspace/${PN/gwn/GWN}"
ECVS_CO_OPTS="-P -D ${PV/*_pre}"
ECVS_UP_OPTS="-dP -D ${PV/*_pre}"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/savannah.gnu.org-gnustep"
inherit gnustep cvs

S=${WORKDIR}/${ECVS_MODULE}

DESCRIPTION="A GNUstep network filesystem file browser."
HOMEPAGE="http://www.gnustep.it/enrico/gworkspace/"

KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"

IUSE="${IUSE}"
# Yes, currently this app does not optional depend on smb, it requires it
DEPEND="${GS_DEPEND}
	gnustep-libs/smbkit"
RDEPEND="${GS_RDEPEND}
	gnustep-libs/smbkit"

egnustep_install_domain "System"

