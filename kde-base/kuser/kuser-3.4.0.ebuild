# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kuser/kuser-3.4.0.ebuild,v 1.4 2005/04/03 14:36:35 greg_g Exp $
KMNAME=kdeadmin
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE user (/etc/passwd and other methods) manager"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE=""
DEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/kdesu)"

# TODO add NIS support
