# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/bk2site/bk2site-1.1.8-r1.ebuild,v 1.6 2002/08/14 12:08:07 murphy Exp $

S=${WORKDIR}/${P}

DESCRIPTION="bk2site will transform your Netscape bookmarks file into a yahoo-like website with slashdot-like news."
SRC_URI="mirror://sourceforge/bk2site/${P}.tar.gz"
HOMEPAGE="http://bk2site.sourceforge.net/"
KEYWORDS="x86 sparc sparc64"
SLOT="0"
LICENSE="GPL-2"

DEPEND=""
#RDEPEND=""


src_unpack() {
	unpack $A
        # Apply any patches available for this version
        local patches=`echo ${FILESDIR}/${PV}.[0-9][0-9][0-9]`
        case "$patches" in
                *\]) 
                        ;; # globbing didn't work; no patches available
                *)
                        cd $S
                        for a in $patches; do
                                patch -p0 < $a
                        done
                        ;;
        esac
        patch -f -p0 < ${FILESDIR}/ebuild.patch
}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
	#make || die
}

src_install () {
	make DESTDIR=${D} install || die
	insinto /etc/bk2site
	doins indexbase.html newbase.html otherbase.html searchbase.html
	dodoc bk2site.html *.gif 
	dodoc README COPYING AUTHORS ChangeLog INSTALL NEWS TODO
	exeinto /home/httpd/cgi-bin/bk2site
	doexe *.pl
}
