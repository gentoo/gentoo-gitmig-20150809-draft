# Copyright 1999-2003 Gentoo Technologies, Inc.
# Copyright 2002 moto kawasaki <kawasaki@kawasaki3.org>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/apel/apel-2002.06.21.0106.ebuild,v 1.8 2003/02/13 10:52:32 vapier Exp $

Name=`echo ${P} | sed -e 's#\.##g'`
A="${Name}.tar.gz"
S="${WORKDIR}/${Name}"

DESCRIPTION="A Portable Emacs Library -- apel"
SRC_URI="ftp://ftp.m17n.org/pub/mule/apel/snapshots/${A}"
HOMEPAGE="http://cvs.m17n.org/elisp/APEL/"
DEPEND=">=app-editors/emacs-20.4"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {
	cd ${S};

	make || die
}

src_install() {
	make PREFIX=${D}/usr install || die

	dodoc ChangeLog README* APEL* EMU-ELS
}
