# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Jon Nelson <jnelson@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.4 2002/03/12 16:05:09 tod Exp

S=${WORKDIR}/${P}

# Short one-line description of this package.
DESCRIPTION="bk2site will transform your Netscape bookmarks file into a yahoo-like website with slashdot-like news."

# Point to any required sources; these will be automatically
# downloaded by Portage.
SRC_URI="http://prdownloads.sourceforge.net/bk2site/${P}.tar.gz"

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="http://bk2site.sourceforge.net/"

DEPEND=""

# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND=""

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
