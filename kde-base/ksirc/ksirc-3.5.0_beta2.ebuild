# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksirc/ksirc-3.5.0_beta2.ebuild,v 1.2 2005/10/22 07:28:47 halcy0n Exp $

KMNAME=kdenetwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE irc client"
KEYWORDS="~amd64 ~x86"
IUSE="ssl"

RDEPEND="dev-lang/perl
	 ssl? ( dev-perl/IO-Socket-SSL )"
