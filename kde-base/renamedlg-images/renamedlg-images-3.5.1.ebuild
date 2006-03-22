# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/renamedlg-images/renamedlg-images-3.5.1.ebuild,v 1.2 2006/03/22 20:15:47 danarmak Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="renamedlgplugins/images"
MAXKDEVER=3.5.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="renamedlg plugin for image files"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND=""

