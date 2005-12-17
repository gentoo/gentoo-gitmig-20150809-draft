# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepasswd/kdepasswd-3.5.0.ebuild,v 1.5 2005/12/17 10:13:53 corsair Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE GUI for passwd"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""


DEPEND="
$(deprange $PV $MAXKDEVER kde-base/libkonq)"

KMCOPYLIB="libkonq libkonq"
KMNODOCS=true
