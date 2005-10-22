# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kuser/kuser-3.5.0_beta2.ebuild,v 1.2 2005/10/22 07:38:45 halcy0n Exp $
KMNAME=kdeadmin
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE user (/etc/passwd and other methods) manager"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""

# TODO add NIS support
