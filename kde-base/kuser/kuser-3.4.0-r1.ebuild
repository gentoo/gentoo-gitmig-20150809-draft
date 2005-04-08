# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kuser/kuser-3.4.0-r1.ebuild,v 1.1 2005/04/08 12:29:21 greg_g Exp $
KMNAME=kdeadmin
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE user (/etc/passwd and other methods) manager"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE=""
DEPEND=""

# Fix /etc/passwd corruption (kde bug 100443). Applied for 3.4.1.
PATCHES1="${FILESDIR}/kdeadmin-3.4.0-kuser.patch"

# TODO add NIS support
