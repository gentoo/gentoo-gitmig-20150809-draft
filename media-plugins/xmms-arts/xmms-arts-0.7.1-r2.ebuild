# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-arts/xmms-arts-0.7.1-r2.ebuild,v 1.2 2004/10/21 04:49:44 eradicator Exp $

IUSE=""

NOBMP="1"

inherit xmms-plugin

MY_P=arts_output-${PV}
XMMS_S=${XMMS_WORKDIR}/${MY_P}
BMP_S=${BMP_WORKDIR}/${MY_P}

DESCRIPTION="This output plugin allows xmms to work with arts, KDE's sound system"
HOMEPAGE="http://www.xmms.org/plugins.php"
SRC_URI="http://havardk.xmms.org/plugins/arts_output/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"

DEPEND="kde-base/arts"

DOCS="AUTHORS ChangeLog NEWS README"

src_install() {
	myins_xmms="libdir=`xmms-config --output-plugin-dir`"

	xmms-plugin_src_install
}
