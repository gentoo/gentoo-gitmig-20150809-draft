# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Christian Hubinger <a9806056@unet.univie.ac.at>
# $Header: /var/cvsroot/gentoo-x86/net-misc/kmyfirewall/kmyfirewall-0.4.4.ebuild,v 1.1 2002/06/04 08:24:57 george Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kde 3
DESCRIPTION="Graphical KDE iptables configuration tool"
SRC_URI="ftp://ftp.sourceforge.net/pub/sourceforge/kmyfirewall/kmyfirewall-0.4.4.tar.gz"
HOMEPAGE="http://kmyfirewall.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
