# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/aria/aria-0.10.2_beta7.ebuild,v 1.6 2004/02/09 06:39:48 jhhudso Exp $

IUSE="nls"

P=`echo ${P} | sed s/_beta/test/g`
S=${WORKDIR}/${P}
#A=`echo ${P}.tar.bz2 | sed s/_beta/test/g`

DESCRIPTION="Aria is a download manager with a GTK+ GUI, it downloads files from Internet via HTTP/HTTPS or FTP."
SRC_URI="http://aria.rednoah.com/storage/sources/${P}.tar.bz2"
HOMEPAGE="http://aria.rednoah.com"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "
SLOT="0"

RDEPEND="=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	>=sys-devel/gettext-0.10.35"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext
		>=dev-util/intltool-0.11 )"


src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	dodoc AUTHORS README* NEWS ChangeLog TODO COPYING
}

