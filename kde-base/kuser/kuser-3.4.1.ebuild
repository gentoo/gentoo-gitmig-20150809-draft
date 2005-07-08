# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kuser/kuser-3.4.1.ebuild,v 1.6 2005/07/08 03:24:59 weeve Exp $
KMNAME=kdeadmin
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE user (/etc/passwd and other methods) manager"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""
DEPEND=""

# TODO add NIS support
