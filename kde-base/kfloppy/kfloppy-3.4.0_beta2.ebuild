# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kfloppy/kfloppy-3.4.0_beta2.ebuild,v 1.2 2005/02/27 20:21:35 danarmak Exp $

KMNAME=kdeutils
MAXKDEVER=3.4.0_rc1
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KFloppy - formats disks and puts a DOS or ext2fs filesystem on them."
KEYWORDS="~x86"
IUSE=""