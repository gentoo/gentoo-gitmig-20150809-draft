# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Christian Hubinger <a9806056@unet.univie.ac.at>
# $Header: /var/cvsroot/gentoo-x86/net-firewall/kmyfirewall/kmyfirewall-0.9.6.ebuild,v 1.2 2003/10/03 14:27:22 caleb Exp $
inherit kde
need-kde 3

IUSE=""
DESCRIPTION="Graphical KDE iptables configuration tool"
SRC_URI="mirror://sourceforge/$PN/$P.tar.bz2"
HOMEPAGE="http://kmyfirewall.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack() {
	kde_src_unpack
	cp ${S}/kmyfirewall/kmyfirewallrc ${S}/kmyfirewall/kmyfirewallrc.new
	sed -e 's:gentoo_mode=false:gentoo_mode=true:' ${S}/kmyfirewall/kmyfirewallrc.new > ${S}/kmyfirewall/kmyfirewallrc
}
