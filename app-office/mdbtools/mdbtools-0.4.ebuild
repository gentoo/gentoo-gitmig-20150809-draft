# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/mdbtools/mdbtools-0.4.ebuild,v 1.5 2003/07/02 11:45:09 aliz Exp $

DESCRIPTION="A set of libraries and utilities for reading Microsoft Access database (MDB) files"
HOMEPAGE="http://sourceforge.net/projects/mdbtools/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=x11-libs/gtk+-1.2.0
	>=sys-libs/libtermcap-compat-1.2.3
	>=sys-devel/flex-2.5.0
	>=sys-devel/bison-1.35
	odbc? ( >=dev-db/unixODBC-2.0 )"

src_unpack() {
	unpack ${A}
	cd ${S} || die
	patch -p1 <${FILESDIR}/mdbtools-0.4-termcap.diff || die
}

src_compile() {
	local myconf
	use odbc && myconf="${myconf} --with-unixodbc=/usr"

	./configure \
		--enable-sql \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--host=${CHOST} ${myconf} || die "./configure failed"

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	# The install process installs pixmaps include the /usr/include
	# directory.  There are also some .h files that aren't included
	# in any of the RPM files on the sourceforge site, so I'm
	# thinking they are put here by mistake, like the pixmaps.
	rm ${D}/usr/include/*.xpm ${D}/usr/include/gmdb.h \
		${D}/usr/include/gtkhlist.h ${D}/usr/include/connectparams.h

	dodoc COPYING* NEWS README* TODO AUTHORS HACKING ChangeLog
}
