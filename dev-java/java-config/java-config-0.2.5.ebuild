# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-config/java-config-0.2.5.ebuild,v 1.1 2002/09/07 23:45:00 owen Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gentoo-specific configuration for Java"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/~karltk/projects/java-config"
DEPEND=""
#RDEPEND=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc sparc64"

src_install () {
	dobin ${FILESDIR}/java-config-0.2.5
	doman ${FILESDIR}/java-config.1
}
