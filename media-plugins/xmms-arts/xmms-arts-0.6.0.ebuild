# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-arts/xmms-arts-0.6.0.ebuild,v 1.1 2003/09/15 12:16:36 seemant Exp $

IUSE=""

MY_P=arts_output-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="This output plugin allows xmms to work with arts, KDE's sound system"
HOMEPAGE="http://www.xmms.org/plugins.php"
SRC_URI="http://havardk.xmms.org/plugins/arts_output/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm"

newdepend ">=media-sound/xmms-1.2.7
	kde-base/arts"

src_install() {
	einstall libdir=${D}/usr/lib/xmms/Output || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
} 
