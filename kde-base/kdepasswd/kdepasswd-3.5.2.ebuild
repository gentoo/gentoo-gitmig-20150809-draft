# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepasswd/kdepasswd-3.5.2.ebuild,v 1.1 2006/03/22 20:15:05 danarmak Exp $

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
