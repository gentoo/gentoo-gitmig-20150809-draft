# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksirc/ksirc-3.4.1.ebuild,v 1.6 2005/07/08 04:19:05 weeve Exp $

KMNAME=kdenetwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE irc client"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="ssl"

RDEPEND="dev-lang/perl
	 ssl? ( dev-perl/IO-Socket-SSL )"
