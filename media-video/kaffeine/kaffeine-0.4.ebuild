# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kaffeine/kaffeine-0.4.ebuild,v 1.1 2003/11/20 12:53:54 sergey Exp $
inherit kde-base
need-kde 3

DESCRIPTION="The Kaffeine media player for KDE3 based on xine-lib."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://members.chello.at/kaffeine"
LICENSE="GPL-2"
IUSE=""
newdepend ">=media-libs/xine-lib-1_beta12
			 sys-devel/gettext"
SLOT="0"
KEYWORDS="~x86"

src_unpack() {
	kde_src_unpack
	# Doc's will not build on kde 3.2.
	if [ -n `echo $KDEDIR | grep '3.2'` ]
	then
		sed Makefile.am -e s:'SUBDIRS = kaffeine po doc misc addons':'SUBDIRS = kaffeine po misc addons': > Makefile.new
		mv Makefile.new Makefile.am	
	fi
}
