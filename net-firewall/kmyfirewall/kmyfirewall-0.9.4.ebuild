# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Christian Hubinger <a9806056@unet.univie.ac.at>
# $Header: /var/cvsroot/gentoo-x86/net-firewall/kmyfirewall/kmyfirewall-0.9.4.ebuild,v 1.2 2003/07/13 11:49:05 aliz Exp $
inherit kde-base
need-kde 3

DESCRIPTION="Graphical KDE iptables configuration tool"
SRC_URI="mirror://sourceforge/$PN/$P.tar.bz2"
HOMEPAGE="http://kmyfirewall.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86"

S="$WORKDIR/$P-r1" # no idea why
