# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/vile/vile-9.2z.ebuild,v 1.6 2003/06/29 18:24:09 aliz Exp $

IUSE="perl"

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
	ftp://ftp.phred.org/pub/vile/patches/vile-9.2p.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.2q.patch.gz
	ftp://ftp.phred.org/pub/vile/patches/vile-9.2r.patch.gz
        ftp://ftp.phred.org/pub/vile/patches/vile-9.2s.patch.gz 
        ftp://ftp.phred.org/pub/vile/patches/vile-9.2t.patch.gz 
        ftp://ftp.phred.org/pub/vile/patches/vile-9.2u.patch.gz 
        ftp://ftp.phred.org/pub/vile/patches/vile-9.2v.patch.gz 
        ftp://ftp.phred.org/pub/vile/patches/vile-9.2w.patch.gz 
        ftp://ftp.phred.org/pub/vile/patches/vile-9.2x.patch.gz 
        ftp://ftp.phred.org/pub/vile/patches/vile-9.2y.patch.gz 
        ftp://ftp.phred.org/pub/vile/patches/vile-9.2z.patch.gz" 

HOMEPAGE="http://www.clark.net/pub/dickey/vile/vile.html"

DEPEND="${RDEPEND}
	sys-devel/flex"

RDEPEND=">=sys-libs/ncurses-5.2
 	perl? ( dev-lang/perl )"

PROVIDE="virtual/editor"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc "

src_unpack() {
	unpack vile-9.2.tgz

	cd ${S}
	local i
	for i in a b c d e f g h i j k l m n o p q r s t u v w x y z
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
	dodoc CHANGES* COPYING MANIFEST INSTALL README* doc/*
}
