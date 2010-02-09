# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/killbots/killbots-4.4.0.ebuild,v 1.1 2010/02/09 00:16:49 alexxy Exp $

EAPI="2"

KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="Kill the bots or they kill you!"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

# Tests hang, last checked in 4.3.3
RESTRICT="test"
