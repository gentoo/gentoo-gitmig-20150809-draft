# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-null/xmms-null-0.3.ebuild,v 1.3 2004/03/29 23:35:34 dholm Exp $

MY_P="null_output-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A null output plugin for xmms"
SRC_URI="http://havardk.xmms.org/plugins/null_output/${MY_P}.tar.gz"
HOMEPAGE="http://havardk.xmms.org/plugins/null_output"

DEPEND="media-sound/xmms"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

IUSE=""

S=${WORKDIR}/null_output-${PV}

DOCS="AUTHORS ChangeLog NEWS"

src_install () {
	make DESTDIR=${D} install || die
	dodoc ${DOCS}
}
