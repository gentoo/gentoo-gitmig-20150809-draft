# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/fresco-base/fresco-env/fresco-env-1.0.ebuild,v 1.3 2003/02/13 12:03:42 vapier Exp $

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

