# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Eyez <eyez@infinite.fsw.leidenuniv.nl>
# $Header: /var/cvsroot/gentoo-x86/dev-util/astyle/astyle-1.15.3.ebuild,v 1.1 2002/04/24 20:29:01 karltk Exp $

ZIP="astyle_${PV}.zip"
S=${WORKDIR}
DESCRIPTION="Artistic Style is a reindenter and reformatter of C++, C and Java
source code."
SRC_URI="http://prdownloads.sourceforge.net/astyle/${ZIP}"
HOMEPAGE="http://astyle.sourceforge.net"
DEPEND=">=app-arch/unzip-5.42"

src_compile() {
	emake || die
}

src_install () {
	into /usr
	dobin astyle
	dohtml astyle.html astyle_release_notes.html license.html
	dodoc INSTALL.TXT
}
