# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-config/java-config-0.2.2.ebuild,v 1.3 2002/08/01 11:40:14 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gentoo-specific configuration for Java"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/~karltk/java-config"
DEPEND=""
#RDEPEND=""

src_install () {
	dobin ${FILESDIR}/java-config
	doman ${FILESDIR}/java-config.1
}
