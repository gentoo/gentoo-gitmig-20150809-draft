# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Michael Conrad Tilstra <tadpol@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/latex2html/latex2html-2002.ebuild,v 1.2 2002/07/16 03:57:21 owen Exp $

S=${WORKDIR}/${P}
DESCRIPTION="LATEX2HTML is a convertor written in Perl that converts LATEX documents to HTML."
SRC_URI="http://saftsack.fs.uni-bayreuth.de/~latex2ht/current/${P}.tar.gz"
HOMEPAGE="http://www.latex2html.org"
KEYWORDS="x86 ppc"
DEPEND="virtual/glibc"

RDEPEND="app-text/ghostscript
	app-text/tetex
	media-libs/netpbm
	sys-devel/perl
	gif? ( media-libs/giflib
		media-libs/libungif )
	png? ( media-libs/libpng )"
  

src_compile() {
	
	local myconf

	use gif && myconf="${myconf} --enable-gif"
	use png && myconf="${myconf} --enable-png"

	myconf="${myconf} \
		--enable-pk \
		--enable-eps \
		--enable-reverse \
		--enable-pipes \
		--enable-paths \
		--enable-wrapper"

	econf ${myconf} || die
	make || die
	make check || die
}

src_install () {
	# modify cfgcache.pm
	[ -f cfgcache.pm.backup ] && mv cfgcache.pm.backup cfgcache.pm
	cat cfgcache.pm | sed \
		-e "/BINDIR/s:/usr/bin:${D}usr/bin:" \
		-e "/LIBDIR/s:/usr/share/lib:${D}usr/lib:" \
		-e "/TEXPATH/s:/usr/share:${D}usr/share:" \
		-e '/MKTEXLSR/s:/usr/bin/mktexlsr::' > cfgcache.NEW
	mv cfgcache.pm cfgcache.pm.backup
	mv cfgcache.NEW cfgcache.pm
	
	dodir /usr/bin /usr/lib/latex2html /usr/share/texmf/tex/latex/html
	make \
        LIBDIR=${D}/usr/lib/latex2html \
        install || die

	cp cfgcache.pm.backup ${D}/usr/lib/latex2html/cfgcache.pm
	#Install docs
	dodoc BUGS Changes FAQ INSTALL LICENSE MANIFEST README TODO
}

pkg_postinst() {
	einfo "Running mktexlsr to rebuild ls-R database...."
	mktexlsr
}


# vim: ai et sw=4 ts=4
