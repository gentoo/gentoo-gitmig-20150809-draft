# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Christian Hubinger <a9806056@unet.univie.ac.at>
# $Header: /var/cvsroot/gentoo-x86/net-misc/kmyfirewall/kmyfirewall-0.4.5.ebuild,v 1.2 2002/08/14 12:08:08 murphy Exp $

inherit kde-base || die
need-kde 3

S=${WORKDIR}/${PN}

DESCRIPTION="Graphical KDE iptables configuration tool"
SRC_URI="ftp://ftp.sourceforge.net/pub/sourceforge/kmyfirewall/kmyfirewall-0.4.5-rc1.tar.gz"
HOMEPAGE="http://kmyfirewall.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"
SLOT="0"


