# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kfloppy/kfloppy-3.5.0.ebuild,v 1.3 2005/12/04 12:26:00 kloeri Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KFloppy - formats disks and puts a DOS or ext2fs filesystem on them."
KEYWORDS="~alpha ~amd64 ~sparc ~x86"
IUSE=""