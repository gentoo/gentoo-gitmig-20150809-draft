# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/fresco-base/fresco-env/fresco-env-1.0.ebuild,v 1.1 2002/08/12 16:24:40 phoenix Exp $

S=${WORKDIR}
DESCRIPTION="fresco-env -- dependency setup for fresco"
HOMEPAGE="http://www2.fresco.org"
KEYWORDS="x86"
SLOT="0"
LICENSE="fresco"

src_install() {
	mkdir -p etc/env.d
	insinto etc/env.d
	doins ${FILESDIR}/90fresco
}

