# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdialog/kdialog-3.5.0.ebuild,v 1.6 2006/03/22 20:15:17 danarmak Exp $

KMNAME=kdebase
MAXKDEVER=3.5.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDialog can be used to show nice dialog boxes from shell scripts"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="virtual/eject"

KMEXTRA="kdeeject"
KMNODOCS=true
