# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Felix Kurth <felix@fkurth.de>

A="${P}.tar.gz Audio-CD-0.04-disc-cover-1.1.0.tar.gz"
S=${WORKDIR}/${P}


CATEGORY="media-sound"
DESCRIPTION="Creates CD-Covers via Latex by fetching cd-info from freedb.org or local file"

SRC_PATH="http://www.liacs.nl/~jvhemert/disc-cover/download"
HOMEPAGE="http://www.liacs.nl/~jvhemert/disc-cover"

SRC_URI="$SRC_PATH/libraries/Audio-CD-0.04-disc-cover-1.1.0.tar.gz
         $SRC_PATH/unstable/${P}.tar.gz"

DEPEND=">=dev-perl/MIME-Base64-2.12
        >=dev-perl/URI-1.10
	>=dev-perl/HTML-Parser-3.15
	>=dev-perl/Digest-MD5-2.12
	>=dev-perl/libnet-1.0703-r1
	>=dev-perl/libwww-perl-5.50
	>=media-libs/libcdaudio-0.99.6    
        >=app-text/tetex-1.0.7-r7"
	
src_compile() {
    cd ${WORKDIR}/Audio-CD-0.04-disc-cover-1.1.0
    perl Makefile.PL || die	
    make || die 
    make test || die
    #nothing to do for disc-cover itself
}

src_install () {
    cd ${WORKDIR}/Audio-CD-0.04-disc-cover-1.1.0
    make install || die
    dodoc ChangeLog MANIFEST README
    cd ${S}
    into /usr
    dobin disc-cover
    dodoc AUTHORS CHANGELOG COPYING TODO
    docinto freedb
    dodoc freedb/*
    docinto docs
    docinto docs/english
    dodoc docs/english/*
    docinto docs/dutch
    dodoc docs/dutch/*
    docinto docs/german
    dodoc docs/german/*
    docinto docs/spanish
    dodoc docs/spanish/*
}

