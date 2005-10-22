# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeadmin-kfile-plugins/kdeadmin-kfile-plugins-3.5.0_beta2.ebuild,v 1.2 2005/10/22 06:38:13 halcy0n Exp $
KMNAME=kdeadmin
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta
KMMODULE=kfile-plugins

DESCRIPTION="kfile plugins from kdeadmin"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""

