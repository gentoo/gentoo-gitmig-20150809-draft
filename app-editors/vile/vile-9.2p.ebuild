# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/vile/vile-9.2p.ebuild,v 1.4 2002/07/25 20:32:22 kabau Exp $

S=${WORKDIR}/vile-9.2
DESCRIPTION="VI Like Emacs -- yet another full-featured vi clone"
SRC_URI="ftp://ftp.phred.org/pub/vile/vile-9.2.tgz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.2a.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.2b.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.2c.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.2d.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.2e.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.2f.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.2g.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.2h.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.2i.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.2j.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.2k.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.2l.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.2m.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.2n.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.2o.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.2p.patch.gz"
HOMEPAGE="http://invisible-island.net/vile/"

DEPEND="virtual/glibc
	sys-devel/flex
	>=sys-libs/ncurses-5.2
	perl? ( sys-devel/perl )"

RDEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack() {
	unpack vile-9.2.tgz

	cd ${S}
	local i
	for i in a b c d e f g h i j k l m n o p
	do
		gunzip -c ${DISTDIR}/vile-9.2$i.patch.gz | patch -p1
	done
}

src_compile() {
	local myconf
	use perl && myconf="--with-perl"

	./configure --prefix=/usr --host=${CHOST} \
		--mandir=/usr/share/man \
		--with-ncurses \
		$myconf || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc CHANGES* MANIFEST README
}
