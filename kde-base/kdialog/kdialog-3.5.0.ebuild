# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdialog/kdialog-3.5.0.ebuild,v 1.1 2005/11/22 22:14:05 danarmak Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDialog can be used to show nice dialog boxes from shell scripts"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="virtual/eject"

KMEXTRA="kdeeject"
KMNODOCS=true
