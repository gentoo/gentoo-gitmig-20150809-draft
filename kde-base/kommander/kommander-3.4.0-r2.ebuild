# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kommander/kommander-3.4.0-r2.ebuild,v 1.3 2005/05/28 20:43:17 corsair Exp $
KMNAME=kdewebdev
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE dialog system for scripting"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND=""

src_unpack(){
	kde-meta_src_unpack
	epatch ${FILESDIR}/post-3.4-kdewebdev-2.diff
}
