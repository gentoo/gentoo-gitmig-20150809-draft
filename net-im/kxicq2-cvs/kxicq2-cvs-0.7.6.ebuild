# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kxicq2-cvs/kxicq2-cvs-0.7.6.ebuild,v 1.1 2002/11/18 13:02:26 aliz Exp $

inherit kde-base cvs

need-kde 3

LICENSE="GPL-2"
KEYWORDS="~x86"
HOMEPAGE="http://www.kxicq.org"
DESCRIPTION="KDE ICQ Client, using the ICQ2000 protocol"

PATCHES="$FILESDIR/$PN-gcc3.diff"

newdepend "media-libs/xpm"

ECVS_SERVER="cvs.kxicq.sourceforge.net:/cvsroot/kxicq"
ECVS_MODULE="kxicq2"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${PN}"
S=${WORKDIR}/${ECVS_MODULE}
