# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/renamedlg-images/renamedlg-images-3.4.0_beta2.ebuild,v 1.3 2005/03/09 15:00:19 cryos Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="renamedlgplugins/images"
MAXKDEVER=3.4.0_rc1
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="renamedlg plugin for image files"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=""

