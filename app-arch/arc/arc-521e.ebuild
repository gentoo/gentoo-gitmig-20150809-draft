# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Enrico Morelli - 20/06/2002

DESCRIPTION="Create & extract files from DOS .ARC files."

DEPEND="virtual/glibc"
MY_P="${PN}${PV}.pl8"
#SRC_URI="ftp://ftp.kiarchive.ru/pub/unix/arcers/${M_P}.tar.Z"
SRC_URI="${MY_P}.tar.Z"
RESTRICT="fetch"

KEYWORDS="x86"
SLOT="0"
LICENSE="ARC"

dyn_fetch() {
        for y in ${A}
        do
                digest_check ${y}
                        if [ $? -ne 0 ]; then
                                einfo "Please download ${MY_P}.tar.Z from ftp.kiarchive.ru/pub/unix/arcers"
                        einfo "and place it in ${DISTDIR}"
                                exit 1
                        fi
        done
}

src_unpack () {
        # You must download arc-521e.pl8.tar.Z
        # from ftp.kiarchive.ru/pub/unix/arcers  and put it in ${DISTDIR}

	unpack ${A}
	cd ${WORKDIR}
	patch -p1 < ${FILESDIR}/${P}-timeh.patch
	cat marc.c | sed -e 's/char \*arctemp2, \*mktemp();/char *arctemp2;/' \
	-e 's/mktemp/mkstemp/g' > marc.c.new
	mv marc.c.new  marc.c
	cat arc.c | sed -e 's/\*arctemp2, \*mktemp();/*arctemp2;/g' \
	-e 's/mktemp/mkstemp/g' > arc.c.new
	mv arc.c.new arc.c

	cp Makefile Makefile.orig
	sed "s:\$(OPT):${CFLAGS}:" Makefile.orig >Makefile

}

src_compile () {

	cd ${WORKDIR}

	emake || die
}

src_install () {

	cd ${WORKDIR}
	into /usr
	dobin arc marc
	doman arc.1
}
