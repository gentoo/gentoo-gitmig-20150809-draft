# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/man/man-1.5l-r6.ebuild,v 1.9 2003/12/17 04:00:54 brad_mssw Exp $

IUSE="nls"

inherit eutils

NV="${PV}"
S="${WORKDIR}/${PN}-${NV}"
DESCRIPTION="Standard commands to read man pages"
SRC_URI="mirror://kernel/linux/utils/man/man-${NV}.tar.gz"
HOMEPAGE="http://freshmeat.net/projects/man/"

DEPEND="virtual/glibc
	>=sys-apps/sed-4"

RDEPEND="sys-apps/cronbase
	>=sys-apps/groff-1.18"

SLOT="0"
KEYWORDS="x86 amd64 ppc sparc alpha hppa ~arm mips ppc64"
LICENSE="GPL-2"

src_unpack() {
	unpack ${A}

	cd ${S} && \
	sed -i \
		-e 's:/usr/lib/locale:$(prefix)/usr/lib/locale:g' \
		-e 's!/usr/bin:/usr/ucb:!/usr/bin:!' \
		configure || die "configure sed failed"

	sed -i -e 's:cc -o:$(CC) -o:' gencat/Makefile \
		|| die "gencat/Makefile sed failed"

	# security fix
	epatch ${FILESDIR}/${P}-security.patch

	# Fix search order in man.conf so that system installed manpages
	# will be found first ...
	epatch ${FILESDIR}/${P}-search-order.patch

	# For groff-1.18 or later we need to call nroff with '-c'
	epatch ${FILESDIR}/${P}-groff-1.18.patch

	# Fix wierd failing in rare cases
	epatch ${FILESDIR}/${P}-wrong-quotes-v2.patch

	# Fix a crash when calling man with:  man -k "foo bar" (bug #9761).
	# <azarah@gentoo.org> (26 Dec 2002).
	epatch ${FILESDIR}/${P}-util_c-segfault.patch

	# Various fixes from Redhat
	epatch ${FILESDIR}/${P}-redhat-patches.patch

	# Do not print the 'man: No such file or directory' error if
	# 'man -d' was called and the NLS catalogue was not found, as
	# it confuses people, and be more informative  ... (bug #6360)
	# <azarah@gentoo.org> (26 Dec 2002).
	epatch ${FILESDIR}/${P}-locale-debug-info.patch

	# Line length overidden by noff macros, thanks to 
	# <grant.mcdorman@sympatico.ca> for the patch, (bug #21018). 
	# 	-taviso@gentoo.org
	epatch ${FILESDIR}/${P}-LL-linelength.patch
}

src_compile() {
	local myconf=

	use nls && myconf="+lang all"

	./configure -confdir=/etc \
		+sgid +fhs \
		${myconf} || die "configure failed"

	emake -j1 || die "emake failed"
}

src_install() {
	dodir /usr/{bin,sbin}
	cd ${S}
	make PREFIX=${D} install || die "make install failed"

	insinto /etc
	doins src/man.conf

	dodoc COPYING LSM README* TODO

	if [ -n "`use nls`" ]
	then
		cd ${S}/msgs
		./inst.sh ?? ${D}/usr/share/locale/%L/%N
	fi

	chown root:man ${D}/usr/bin/man
	chmod 2555 ${D}/usr/bin/man

	# Needed for makewhatis
	keepdir /var/cache/man

	exeinto /etc/cron.daily
	doexe ${FILESDIR}/makewhatis.cron

	for x in $(awk '
		/^MANSECT/ {
			split($2, sects, ":")
			for (x in sects)
				print "cat" sects[x]
		}' ${D}/etc/man.conf)
	do
		keepdir /var/cache/man/${x}
	done
}

