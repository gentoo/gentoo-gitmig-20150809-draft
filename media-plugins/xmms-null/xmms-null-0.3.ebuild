# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-null/xmms-null-0.3.ebuild,v 1.9 2004/11/27 20:27:03 corsair Exp $

IUSE=""

inherit gnuconfig

MY_P="null_output-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A null output plugin for xmms"
SRC_URI="http://havardk.xmms.org/plugins/null_output/${MY_P}.tar.gz"
HOMEPAGE="http://havardk.xmms.org/plugins/null_output"

DEPEND="media-sound/xmms"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc amd64 sparc ~ppc64"

S=${WORKDIR}/null_output-${PV}

DOCS="AUTHORS ChangeLog NEWS"

src_unpack() {
	unpack ${A}
	cd ${S}
	gnuconfig_update
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc ${DOCS}
}
