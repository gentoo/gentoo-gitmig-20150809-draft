# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/logjam/logjam-3.0.4-r1.ebuild,v 1.7 2003/09/05 22:01:49 msterret Exp $

IUSE="xmms gnome"

# NOTE: The comments in this file are for instruction and documentation.
# They're not meant to appear with your final, production ebuild.  Please
# remember to remove them before submitting or committing your ebuild.  That
# doesn't mean you can't add your own comments though.

DESCRIPTION="A GTK+ LiveJournal Client"
HOMEPAGE="http://logjam.danga.com"
KEYWORDS="x86 sparc "
LICENSE="GPL-2"
SLOT="0"
DEPEND=">=net-ftp/curl-7.9.3
	>=x11-libs/gtk+-1.2.10-r7
	gnome? ( >=gnome-base/gnome-libs-1.4.1.6 )
	xmms? ( >=media-sound/xmms-1.2.7-r4 )"
SRC_URI="http://logjam.danga.com/download/${P}.tar.gz"

# Source directory; the dir where the sources can be found (automatically
# unpacked) inside ${WORKDIR}.  S will get a default setting of ${WORKDIR}/${P}
# if you omit this line.

S=${WORKDIR}/${P}

src_compile() {

	local myconf

	use gnome && myconf="--with-gnome "
	use xmms && myconf="$myconf --with-xmms "

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		${myconf} \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
