# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdetoys/kdetoys-3.0-r1.ebuild,v 1.1 2002/05/10 12:07:56 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
CHILDREN="~app-misc/amor-2.2
	  ~app-misc/kmoon-1.0
	  ~app-misc/eyesapplet-1.0.0
	  ~app-misc/fifteenapplet-1.0.0
	  ~app-misc/kaphorism-3.0
	  ~app-misc/kmoon-1.0
	  ~app-misc/kodo-3.2
	  ~app-misc/kteatime-0.0.1
	  ~app-misc/ktux-1.0.0
	  ~app-misc/kweather-1.0.0
	  ~app-misc/kworldwatch-1.5"

# disabled by default:
# ~app-misc/kfortune-0.1
# ~app-misc/kscore-0.1.0
PN=kdetoys
PV=3.0
P=$PN-$PV
inherit kde-dist kde-parent

DESCRIPTION="${DESCRIPTION}Toys"



