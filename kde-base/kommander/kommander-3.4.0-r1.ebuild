# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kommander/kommander-3.4.0-r1.ebuild,v 1.1 2005/04/19 23:59:30 carlo Exp $
KMNAME=kdewebdev
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE dialog system for scripting"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""
DEPEND=""

src_unpack(){
	kde-meta_src_unpack
	epatch ${FILESDIR}/post-3.4-kdewebdev.diff
}
