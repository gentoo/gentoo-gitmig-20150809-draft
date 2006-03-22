# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kompare/kompare-3.5.1.ebuild,v 1.2 2006/03/22 20:15:31 danarmak Exp $

KMNAME=kdesdk
MAXKDEVER=3.5.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: A program to view the differences between files and optionally generate a diff"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""