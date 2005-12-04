# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksirc/ksirc-3.5.0.ebuild,v 1.3 2005/12/04 11:21:59 kloeri Exp $

KMNAME=kdenetwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE irc client"
KEYWORDS="~alpha ~amd64 ~sparc ~x86"
IUSE="ssl"

RDEPEND="dev-lang/perl
	 ssl? ( dev-perl/IO-Socket-SSL )"
