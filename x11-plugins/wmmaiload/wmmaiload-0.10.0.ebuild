# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmaiload/wmmaiload-0.10.0.ebuild,v 1.1 2004/03/22 01:36:36 rizzo Exp $

S=${WORKDIR}/${P}

DESCRIPTION="dockapp that monitors one or more mailboxes."
SRC_URI="http://tnemeth.free.fr/projets/programmes/${P}.tar.gz"
HOMEPAGE="http://tnemeth.free.fr/projets/dockapps.html"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
LICENSE="GPL-2"

DEPEND="x11-base/xfree"
IUSE=""

src_compile() {

	econf || die "configure failed"

	emake || die "parallel make failed"

}

src_install () {

	einstall || die "make install failed"

}

