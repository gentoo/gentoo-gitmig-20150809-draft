# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kicker/kicker-3.4.2.ebuild,v 1.2 2005/08/08 22:26:57 kloeri Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE panel housing varous applets"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
PATCHES="$FILESDIR/applets-configure.in.in.diff"
OLDDEPEND="~kde-base/libkonq-3.3.1"
DEPEND="
$(deprange $PV $MAXKDEVER kde-base/libkonq)
$(deprange $PV $MAXKDEVER kde-base/kdebase-data)"

KMCOPYLIB="libkonq libkonq"
KMEXTRACTONLY="libkonq
	kdm/kfrontend/themer/"
KMCOMPILEONLY="kdmlib/"
