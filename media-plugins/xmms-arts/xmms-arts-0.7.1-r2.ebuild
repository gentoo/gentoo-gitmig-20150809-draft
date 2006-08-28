# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-arts/xmms-arts-0.7.1-r2.ebuild,v 1.14 2006/08/28 18:29:29 jer Exp $

inherit eutils

MY_P=arts_output-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="This output plugin allows xmms to work with arts, KDE's sound system"
HOMEPAGE="http://www.xmms.org/plugins.php"
SRC_URI="http://havardk.xmms.org/plugins/arts_output/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=media-sound/xmms-1.2.7
	kde-base/arts"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-eintr.patch
}

src_install() {
	make DESTDIR=${D} libdir=`xmms-config --output-plugin-dir` install || die

	dodoc AUTHORS ChangeLog NEWS README
}
