# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: George Shapovalov <georges@its.caltech.edu>
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.4 2002/03/12 16:05:09 tod Exp


S="${WORKDIR}/${P}"
DESCRIPTION="A command-line based audio CD ripper and mp3 encoder"
SRC_URI="http://rip.sourceforge.net/download/${P}.tar.gz"
HOMEPAGE="http://rip.sourceforge.net"

DEPEND=""

RDEPEND="media-sound/cdparanoia
	media-sound/lame"

# Use this function to unpack your sources and apply patches, and run
# autoconf/automake/etc. if necessary. By default, this function unpacks
# the packages in ${A} and applies ${PF}-gentoo.diff. The default
# starting directory is ${WORKDIR}.
#
src_unpack() {
	unpack "${P}.tar.gz"
	cd "${S}"
	#we need to unpack supplementary perl modules
	tar xzf CDDB_get-1.66.tar.gz
	tar xzf MP3-Info-0.91.tar.gz
}

src_compile() {
	#the thing itself is just a perl script
	#but we need to make suppl perl modules

	cd CDDB_get-1.66
	perl Makefile.PL && make || die "could not prepare CDDB access perl module"
	cd ..

    cd MP3-Info-0.91
    perl Makefile.PL && make || die "could not prepare CDDB access perl module"
    cd ..

}

src_install () {

	chmod 755 rip
	dobin rip || die

	#now we need to install perl modules
	cd CDDB_get-1.66
    make \
    PREFIX=${D}/usr \
    INSTALLMAN3DIR=${D}/usr/share/man/man3 \
    INSTALLMAN1DIR=${D}/usr/share/man/man1 \
    install || die

	
	cd ../MP3-Info-0.91
    make \
    PREFIX=${D}/usr \
    INSTALLMAN3DIR=${D}/usr/share/man/man3 \
    INSTALLMAN1DIR=${D}/usr/share/man/man1 \
    install || die

	# Install documentation.
	dodoc COPYING FAQ README
}
