# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/latex2html/latex2html-2002.1.ebuild,v 1.13 2003/04/23 00:15:45 lostlogic Exp $

MY_P=${P/./-}
S=${WORKDIR}/${MY_P}
DESCRIPTION="LATEX2HTML is a convertor written in Perl that converts LATEX documents to HTML."
SRC_URI="http://saftsack.fs.uni-bayreuth.de/~latex2ht/current/${MY_P}.tar.gz"
HOMEPAGE="http://www.latex2html.org/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc"
IUSE="gif png"

DEPEND="=sys-apps/sed-4*"
RDEPEND="app-text/ghostscript
	app-text/tetex
	media-libs/netpbm
	dev-lang/perl
	gif? ( media-libs/giflib
		media-libs/libungif )
	png? ( media-libs/libpng )"

src_compile() {
	local myconf

	use gif && myconf="${myconf} --enable-gif"
	use png && myconf="${myconf} --enable-png"

	use gif || use png || myconf="${myconf} --disable-images"

	myconf="${myconf} \
		--libdir=/usr/lib/latex2html \
		--shlibdir=/usr/lib/latex2html \
		--enable-pk \
		--enable-eps \
		--enable-reverse \
		--enable-pipes \
		--enable-paths \
		--enable-wrapper"

	econf ${myconf}
	make || die
	make check || die
}

src_install() {
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

	# make /usr/share/latex2html sticky
	touch .keep
	insinto /usr/share/latex2html
	doins .keep

	# clean the perl scripts up to remove references to the sandbox
	sed -i "s:${T}::g" ${D}/usr/lib/latex2html/pstoimg.pl
	sed -i "s:${T}::g" ${D}/usr/lib/latex2html/latex2html.pl
	sed -i "s:${T}::g" ${D}/usr/lib/latex2html/cfgcache.pm
	sed -i "s:${T}::g" ${D}/usr/lib/latex2html/l2hconf.pm
}

pkg_postinst() {
	einfo "Running mktexlsr to rebuild ls-R database...."
	mktexlsr
}
