# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Alexander Papaspyrou <alexander.papaspyrou@udo.edu
# $Header: /var/cvsroot/gentoo-x86/net-misc/knetmonapplet/knetmonapplet-0.6.6.ebuild,v 1.3 2003/02/13 14:57:03 vapier Exp $
inherit kde-base
need-kde 3

DESCRIPTION="Graphical network monitor for the KDE panel"
SRC_URI="http://ftp.kde.com/Computer_Devices/Networking/Monitoring/KnetmonApplet/${P}.tar.gz"
HOMEPAGE="http://perso.club-internet.fr/hftom/knetmonapplet/"

LICENSE="GPL-2"
KEYWORDS="~x86"

src_unpack() {

    kde_src_unpack
    
    rm -f $S/knetmon/uiconfig.{h,cpp,moc}

}
