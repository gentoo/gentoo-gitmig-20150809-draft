# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Ebuild by AutoBot (autobot@midsouth.rr.com)
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmaiload/wmmaiload-0.6.0.ebuild,v 1.3 2003/06/12 22:28:44 msterret Exp $

S=${WORKDIR}/${P}

DESCRIPTION="dockapp that monitors one or more mailboxes."
SRC_URI="http://tnemeth.free.fr/projets/programmes/${P}.tar.gz"
HOMEPAGE="http://tnemeth.free.fr/projets/dockapps.html"

SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"

DEPEND="x11-base/xfree"

src_compile() {

	econf || die "configure failed"

	emake || die "parallel make failed"

}

src_install () {

	einstall || die "make install failed"

}

