# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kfloppy/kfloppy-3.4.1.ebuild,v 1.11 2006/03/27 13:49:44 agriffis Exp $

KMNAME=kdeutils
MAXKDEVER=3.4.3
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KFloppy - formats disks and puts a DOS or ext2fs filesystem on them."
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""