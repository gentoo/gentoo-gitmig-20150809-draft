# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/superkaramba/superkaramba-3.5.3.ebuild,v 1.2 2006/06/02 00:18:13 flameeyes Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="A tool to create interactive applets for the KDE desktop."
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="!x11-misc/superkaramba"

PATCHES="${FILESDIR}/${PN}-3.5.2-multilib-python.diff"
