# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-arts/xmms-arts-0.7.1.ebuild,v 1.3 2004/03/26 21:07:55 eradicator Exp $

IUSE=""

MY_P=arts_output-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="This output plugin allows xmms to work with arts, KDE's sound system"
HOMEPAGE="http://www.xmms.org/plugins.php"
SRC_URI="http://havardk.xmms.org/plugins/arts_output/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"

DEPEND=">=media-sound/xmms-1.2.7
	kde-base/arts"

src_install() {
	make DESTDIR=${D} libdir=${D}`xmms-config --output-plugin-dir` install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
