# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/man/man-1.5k-r1.ebuild,v 1.10 2003/05/25 15:10:30 mholzer Exp $

IUSE=""

inherit eutils

NV="${PV}"
S="${WORKDIR}/${PN}-${NV}"
DESCRIPTION="Standard commands to read man pages"
SRC_URI="mirror://kernel/linux/utils/man/man-${NV}.tar.gz"
HOMEPAGE="http://freshmeat.net/projects/man/"

DEPEND="virtual/glibc"

RDEPEND="sys-apps/cronbase
	>=sys-apps/groff-1.18"

SLOT="0"
KEYWORDS="x86 ppc ~sparc alpha hppa arm mips"
LICENSE="GPL-2"

src_unpack() {
	unpack ${A}
	
	cd ${S}
	cp configure configure.orig
	sed	-e 's:/usr/lib/locale:$(prefix)/usr/lib/locale:g' \
		-e 's!/usr/bin:/usr/ucb:!/usr/bin:!' \
		configure.orig > configure
	
	local x=""
	for x in / src/ man2html/ msgs/
	do
		cd ${S}/${x}
		cp Makefile.in Makefile.in.orig
		sed -e '/inst.sh/d' \
			-e '/^CC =/c\' \
			-e "CC = gcc" \
			-e '/^CFLAGS =/c\' \
			-e "CFLAGS = ${CFLAGS}" \
			Makefile.in.orig > Makefile.in
	done

	cd ${S}/gencat
	cp Makefile Makefile.orig
	sed -e "s:cc -o:gcc -o:" Makefile.orig > Makefile

	cd ${S}
	# Various fixes from Redhat
	epatch ${FILESDIR}/${P}-redhat-patches.patch

	# Fix search order in man.conf so that system installed manpages
	# will be found first ...
	epatch ${FILESDIR}/${P}-search-order.patch

	# For groff-1.18 or later we need to call nroff with '-c'
	epatch ${FILESDIR}/${P}-groff-1.18.patch

	# Fix wierd failing in rare cases
	epatch ${FILESDIR}/${P}-wrong-quotes.patch

	# Fix a crash when calling man with:  man -k "foo bar" (bug #9761).
	# <azarah@gentoo.org> (26 Dec 2002).
	epatch ${FILESDIR}/${P}-util_c-segfault.patch

	# Do not print the 'man: No such file or directory' error if
	# 'man -d' was called and the NLS catalogue was not found, as
	# it confuses people, and be more informative  ... (bug #6360)
	# <azarah@gentoo.org> (26 Dec 2002).
	epatch ${FILESDIR}/${P}-locale-debug-info.patch
}

src_compile() {
	local myconf=""
	use nls && myconf="+lang all"

	./configure -confdir=/etc \
		+sgid +fhs \
		${myconf} || die
		
	make || die
}

src_install() {
	dodir /usr/{bin,sbin}
	cd ${S}
	make PREFIX=${D} install || die

	if [ -n "`use nls`" ]
	then
		cd ${S}/msgs
		./inst.sh ?? ${D}/usr/share/locale/%L/%N
	fi
	
	chmod 2555 ${D}/usr/bin/man
	chown root.man ${D}/usr/bin/man

	# Needed for makewhatis
	keepdir /var/cache/man
	
	insinto /etc
	cd ${S}
	doins src/man.conf
	
	dodoc COPYING LSM README* TODO
	
	exeinto /etc/cron.daily
	doexe ${FILESDIR}/makewhatis.cron
}

