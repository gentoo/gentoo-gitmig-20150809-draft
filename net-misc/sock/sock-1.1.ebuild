# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Jon Nelson <jnelson@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.4 2002/03/12 16:05:09 tod Exp

S=${WORKDIR}/${P}

# Short one-line description of this package.
DESCRIPTION="A shell interface to network sockets"

# Point to any required sources; these will be automatically
# downloaded by Portage.
SRC_URI="ftp://atrey.karlin.mff.cuni.cz/pub/local/mj/net/${P}.tar.gz"

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="http://atrey.karlin.mff.cuni.cz/~mj/linux.shtml"

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
	exeinto /usr/bin
	doexe sock
	doman sock.1
#	make DESTDIR=${D} install || die
	dodoc README ChangeLog
}
