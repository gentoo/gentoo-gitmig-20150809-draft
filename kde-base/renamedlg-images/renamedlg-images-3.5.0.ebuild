# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/renamedlg-images/renamedlg-images-3.5.0.ebuild,v 1.1 2005/11/22 22:14:16 danarmak Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="renamedlgplugins/images"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="renamedlg plugin for image files"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""

