# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/vile/vile-9.3h.ebuild,v 1.6 2003/08/13 09:41:25 weeve Exp $

IUSE="perl"

S=${WORKDIR}/vile-9.3
DESCRIPTION="VI Like Emacs -- yet another full-featured vi clone"
SRC_URI="ftp://ftp.phred.org/pub/vile/vile-9.3.tgz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.3a.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.3b.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.3c.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.3d.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.3e.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.3f.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.3g.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.3h.patch.gz"

HOMEPAGE="http://www.clark.net/pub/dickey/vile/vile.html"

DEPEND="${RDEPEND}
	sys-devel/flex"

RDEPEND=">=sys-libs/ncurses-5.2
 	perl? ( dev-lang/perl )"

PROVIDE="virtual/editor"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc ~alpha"

src_unpack() {
	unpack vile-9.3.tgz

	cd ${S}
	local i
	for i in a b c d e f g h
	do
		gunzip -c ${DISTDIR}/vile-9.3$i.patch.gz | patch -p1
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
	dodoc CHANGES* COPYING MANIFEST INSTALL README* doc/*
}

