# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/bigloo/bigloo-2.6a.ebuild,v 1.1 2004/02/11 22:32:08 jake Exp $

MY_P=${PN}${PV}
S=${WORKDIR}/${PN}${PV}
DESCRIPTION="Bigloo Scheme compiler for x86, sparc, alpha, ppc and JVM"
SRC_URI="ftp://ftp-sop.inria.fr/mimosa/fp/Bigloo/${MY_P}.tar.gz"
HOMEPAGE="http://www-sop.inria.fr/mimosa/fp/Bigloo/bigloo.html"
DEPEND=">=sys-apps/sed-4"
#RDEPEND=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_compile() {
	local myconf
	local myjava=`java-config --java`
	local myjavac=`java-config --javac`

	use java &&
		myconf="--jvm=force --java=$myjava --javac=$myjavac" \
		|| myconf="--jvm=no"


	./configure \
		--native=yes \
		--cflags="${CFLAGS}" \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man/man1 \
		--docdir=/usr/share/doc/${PV} \
		$myconf || die "./configure failed"

	echo LD_LIBRARY_PATH=${S}/lib/${PV} >> Makefile.config

	sed -i "s/JCFLAGS=-O/JCFLAGS=/" Makefile.config || die
	sed -i "s/\$(BOOTBINDIR)\/afile jas/LD_LIBRARY_PATH=\$(LD_LIBRARY_PATH) \$(BOOTBINDIR)\/afile jas/" \
		bde/Makefile || die

	make || die
}

src_install () {
	dodir /usr/bin
	dodir /usr/lib/bigloo/2.5c
	dodir /usr/share/doc/${PF}
	dodir /usr/share/man/man1
	dodir /usr/share/info

	dodir /etc/env.d
	echo "LDPATH=/usr/lib/bigloo/${PV}/" \
		> ${D}/etc/env.d/25bigloo
	make DESTDIR=${D} install || die
}
