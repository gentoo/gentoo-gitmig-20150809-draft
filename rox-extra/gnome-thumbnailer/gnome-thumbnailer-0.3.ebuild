# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/gnome-thumbnailer/gnome-thumbnailer-0.3.ebuild,v 1.1 2007/05/16 14:51:38 lack Exp $

ROX_VER="2.1.1"
ROX_LIB_VER="2.0.2"
inherit rox

MY_PN="ROX-GNOME-thumbnailer"
DESCRIPTION="Generates thumbnails for ROX-Filer using GNOME's thumbnailers"
HOMEPAGE="http://www.theli.ho.com.ua/"
SRC_URI="http://denver.sociol.unimi.it/~yuri/rox/${MY_PN}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~x86"

DEPEND=""

APPNAME=${MY_PN}
S=${WORKDIR}

