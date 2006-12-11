# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/hesiod/hesiod-3.0.2.ebuild,v 1.13 2006/12/11 07:54:11 beu Exp $

inherit flag-o-matic

DESCRIPTION="Hesiod is a system which uses existing DNS functionality to provide access to databases of information that changes infrequently."
SRC_URI="ftp://athena-dist.mit.edu/pub/ATHENA/${PN}/${P}.tar.gz"
HOMEPAGE="ftp://athena-dist.mit.edu/pub/ATHENA/hesiod"

SLOT="0"
LICENSE="ISC"
KEYWORDS="x86 ppc sparc hppa"
IUSE=""

src_unpack() {
	unpack ${A}

	filter-flags -fstack-protector

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
}
