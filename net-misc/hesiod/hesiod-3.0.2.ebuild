# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/hesiod/hesiod-3.0.2.ebuild,v 1.1 2002/06/09 02:25:26 g2boojum Exp $

DESCRIPTION="Hesiod is a system which uses existing DNS functionality to provide access to databases of information that changes infrequently."

HOMEPAGE="ftp://athena-dist.mit.edu/pub/ATHENA/hesiod"
LICENSE="ISC"
DEPEND="virtual/glibc"
#RDEPEND=""
SRC_URI="ftp://athena-dist.mit.edu/pub/ATHENA/${PN}/${P}.tar.gz"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	#Patches stolen from RH
	cat ${FILESDIR}/hesiod-3.0.2-shlib.patch | patch -d ${S} -p1
	cat ${FILESDIR}/hesiod-3.0.2-env.patch | patch -d ${S} -p1
	cat ${FILESDIR}/hesiod-3.0.2-str.patch | patch -d ${S} -p1
	cd ${S}
	for manpage in *.3
	do
		if grep -q '^\.so man3/hesiod.3' ${manpage}
		then
			echo .so hesiod.3 > ${manpage}
		elif grep -q '^\.so man3/hesiod_getmailhost.3' ${manpage}
		then
			echo .so hesiod_getmailhost.3 > ${manpage}
		elif grep -q '^\.so man3/hesiod_getpwnam.3' ${manpage}
		then
			echo .so hesiod_getpwnam.3 > ${manpage}
		elif grep -q '^\.so man3/hesiod_getservbyname.3' ${manpage}
		then
			echo .so hesiod_getservbyname.3 > ${manpage}
		fi
	done
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
	#make \
	#	prefix=${D}/usr \
	#	mandir=${D}/usr/share/man \
	#	infodir=${D}/usr/share/info \
	#	install || die
	# Again, verify the Makefiles!  We don't want anything falling
	# outside of ${D}.
}
