# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Michael Conrad Tilstra <tadpol@gentoo.org> <tadpol@tadpol.org>
# /space/gentoo/cvsroot/gentoo-x86/app-text/latex2html/latex2html-2002.ebuild,v 1.1 2002/04/27 09:22:19 seemant Exp

P="latex2html-2002-1"
S=${WORKDIR}/${P}
DESCRIPTION="LATEX2HTML is a convertor written in Perl that converts LATEX documents to HTML."
SRC_URI="http://saftsack.fs.uni-bayreuth.de/~latex2ht/current/${P}.tar.gz"
HOMEPAGE="http://www.latex2html.org"
SLOT="0"
LICENSE="as-is"

DEPEND="virtual/glibc"
KEYWORDS="x86 ppc sparc sparc64"

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
	--prefix=/usr \
	--libdir=/usr/lib/latex2html \
	--shlibdir=/usr/lib/latex2html \
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

	dodir /usr/bin /usr/lib/latex2html /usr/share/latex2html 
	dodir /usr/share/texmf/tex/latex/html
	cp cfgcache.pm cfgcache.pm.bak

	# mktexlsr is run later to avoid a sandbox violation 
	sed \
		-e "/BINDIR\|LIBDIR\|SHLIBDIR\|TEXPATH/s#q'/#q'"${D}"#" \
		-e "/MKTEXLSR/s:q'.*':q'':" \
		cfgcache.pm.bak > cfgcache.pm

	make install || die
	cp cfgcache.pm.bak ${D}/usr/lib/latex2html/cfgcache.pm

	dodoc BUGS Changes FAQ INSTALL LICENSE MANIFEST README TODO
}

pkg_postinst() {
	einfo "Running mktexlsr to rebuild ls-R database...."
	mktexlsr
}


