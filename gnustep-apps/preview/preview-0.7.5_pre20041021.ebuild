# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/preview/preview-0.7.5_pre20041021.ebuild,v 1.2 2004/10/22 20:06:42 fafhrd Exp $

ECVS_CVS_COMMAND="cvs -q"
ECVS_SERVER="cvs.gna.org:/cvs/gsimageapps"
ECVS_USER="anonymous"
ECVS_AUTH="pserver"
ECVS_MODULE="gsimageapps/Applications/Preview"
ECVS_CO_OPTS="-D ${PV/*_pre}"
ECVS_UP_OPTS="-D ${PV/*_pre}"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/gna.org-gsimageapps"
inherit gnustep cvs

S=${WORKDIR}/${ECVS_MODULE}

DESCRIPTION="A general purpose Viewer application."

HOMEPAGE="http://gna.org/projects/gsimageapps"
#SRC_URI="http://download.gna.org/gsimageapps/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"
SLOT="0"

IUSE="${IUSE}"
DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}"

