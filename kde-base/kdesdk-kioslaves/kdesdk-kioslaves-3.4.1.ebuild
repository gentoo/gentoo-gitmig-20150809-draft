# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-kioslaves/kdesdk-kioslaves-3.4.1.ebuild,v 1.5 2005/07/08 05:09:33 weeve Exp $

KMNAME=kdesdk
KMMODULE=kioslave
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kioslaves from kdesdk package: the subversion kioslave"
KEYWORDS="amd64 ~ppc ppc64 sparc x86"
IUSE=""
DEPEND="dev-util/subversion"
