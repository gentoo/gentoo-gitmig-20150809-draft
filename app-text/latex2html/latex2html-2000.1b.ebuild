# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Michael Conrad Tilstra <tadpol@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/latex2html/latex2html-2000.1b.ebuild,v 1.6 2002/08/02 17:42:49 phoenix Exp $

#darn weird naming...
MY_P=${PN}-2K.1beta
S=${WORKDIR}/${MY_P}
DESCRIPTION="LATEX2HTML is a convertor written in Perl that converts LATEX documents to HTML."
SRC_URI="http://saftsack.fs.uni-bayreuth.de/~latex2ht/current/${MY_P}.tar.gz"
HOMEPAGE="http://www.latex2html.org"
SLOT="0"
LICENSE="as-is"

DEPEND="virtual/glibc"
KEYWORDS="x86 ppc"
RDEPEND="sys-devel/perl
	app-text/ghostscript
	media-libs/netpbm
	app-text/tetex
	"

src_compile() {
	econf || die
	make || die
	make check || die
#	make test || die
}

src_install () {
	# modify cfgcache.pm
	[ -f cfgcache.pm.backup ] && mv cfgcache.pm.backup cfgcache.pm
	cat cfgcache.pm | sed \
		-e "/BINDIR/s:/usr/bin:${D}usr/bin:" \
		-e "/LIBDIR/s:/usr/lib:${D}usr/lib:" \
		-e "/TEXPATH/s:/usr/share:${D}usr/share:" \
		-e '/MKTEXLSR/s:/usr/bin/mktexlsr::' > cfgcache.NEW
	mv cfgcache.pm cfgcache.pm.backup
	mv cfgcache.NEW cfgcache.pm
	
	dodir /usr/bin /usr/lib/latex2html /usr/share/texmf/tex/latex/html
	make install || die

	cp cfgcache.pm.backup ${D}/usr/lib/latex2html/cfgcache.pm
	#Install docs
	dodoc BUGS Changes FAQ INSTALL LICENSE MANIFEST README TODO
}

pkg_postinst() {
	einfo "Running mktexlsr to rebuild ls-R database...."
	mktexlsr
}


# vim: ai et sw=4 ts=4
