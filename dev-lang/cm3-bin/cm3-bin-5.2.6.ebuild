# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/cm3-bin/cm3-bin-5.2.6.ebuild,v 1.1 2003/07/17 17:11:38 vapier Exp $

DESCRIPTION="Critical Mass Modula-3 compiler (binary version)"
HOMEPAGE="http://www.elegosoft.com/cm3/"
SRC_URI="x86? ( http://www.elegosoft.com/cm3/cm3-min-POSIX-LINUXLIBC6-${PV}.tgz )
	ppc? ( http://www.elegosoft.com/cm3/cm3-min-POSIX-PPC_LINUX-${PV}.tgz )"

LICENSE="CMASS-M3 DEC-M3"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="tcltk"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	tar -zxf system.tgz || die "unpacking system.tgz"

	sed \
		-e "s:GENTOO_INITIAL_REACTOR_EDITOR:${EDITOR:-/usr/bin/nano}:" \
		-e "s:GENTOO_INSTALL_ROOT:/usr/lib/cm3/:" \
		-e "s:GENTOO_GNU_CC:${CC:-gcc}:" \
		-e "s:GENTOO_GNU_CFLAGS:${CFLAGS:--O}:" \
		-e "s:GENTOO_GNU_MAKE:${MAKE:-make}:" \
		${FILESDIR}/cm3.cfg > bin/cm3.cfg
	echo "ROOT=\"/usr/lib/cm3/pkg/\"" >> bin/cm3.cfg
	rm -rf doc elisp examples man
}

src_install() {
	dodir /usr/lib/cm3 /usr/bin
	mv pkg bin lib ${D}/usr/lib/cm3/
	dosym /usr/lib/cm3/bin/cm3 /usr/bin/cm3
	dosym /usr/lib/cm3/bin/cm3.cfg /usr/bin/cm3.cfg
	dosym /usr/lib/cm3/bin/cm3cg /usr/bin/cm3cg
	dobin ${FILESDIR}/m3{build,ship}

	insinto /etc/env.d
	doins ${FILESDIR}/05cm3
}
