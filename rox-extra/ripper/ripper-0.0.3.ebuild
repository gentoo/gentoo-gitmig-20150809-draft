# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/ripper/ripper-0.0.3.ebuild,v 1.1 2004/12/09 17:13:20 sergey Exp $

DESCRIPTION="Ripper - A MP3/OGG ripper/encoder for the ROX Desktop"

MY_PN="Ripper"

MY_PV="003"

HOMEPAGE="http://khayber.dyndns.org/rox/ripper"

SRC_URI="http://khayber.dyndns.org/rox/ripper/${MY_PN}-${MY_PV}.tgz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

ROX_LIB_VER=1.9.11

APPNAME=${MY_PN}

S=${WORKDIR}

inherit rox
