# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/renamedlg-images/renamedlg-images-3.5.0.ebuild,v 1.3 2005/12/04 12:47:50 kloeri Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="renamedlgplugins/images"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="renamedlg plugin for image files"
KEYWORDS="~alpha ~amd64 ~sparc ~x86"
IUSE=""
DEPEND=""

