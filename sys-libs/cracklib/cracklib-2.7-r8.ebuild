# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/cracklib/cracklib-2.7-r8.ebuild,v 1.6 2004/02/03 01:15:43 darkspecter Exp $

inherit flag-o-matic eutils

MY_P=${P/-/,}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Password Checking Library"
HOMEPAGE="http://www.crypticide.org/users/alecm/"
SRC_URI="http://www.crypticide.org/users/alecm/security/${MY_P}.tar.gz"

LICENSE="CRACKLIB"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc ~alpha ~mips ~hppa ~arm ~ia64 amd64 ppc64"

RDEPEND="sys-apps/miscfiles
	>=sys-apps/portage-2.0.47-r10"
DEPEND="${RDEPEND}
	sys-devel/gcc-config"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-redhat.patch
	epatch ${FILESDIR}/${P}-gentoo-new.diff
	epatch ${FILESDIR}/${P}-static-lib.patch

	[ "${ARCH}" = "alpha" -a "${CC}" = "ccc" ] && \
		sed -i -e 's:CFLAGS += -g :CFLAGS += -g3 :' ${S}/cracklib/Makefile

	# this is only needed for the transparent hgcc
	if has_version 'sys-devel/hardened-gcc' && [ ${CC} == "gcc" ]
	then
		einfo "hardened-gcc: adding libgcc for propolice __guard symbol to cracklib"
		sed -i "s:= ld:= ld $(gcc-config -L)/libgcc_s.so:" ${S}/cracklib/Makefile
	fi
}

src_compile() {
	filter-flags -fstack-protector
	# Parallel make does not work for 2.7
	make all || die
}

src_install() {
	dodir /usr/{lib,sbin,include}
	keepdir /usr/share/cracklib

	make DESTDIR=${D} install || die

	# Needed by pam
	if [ ! -f "${D}/usr/lib/libcrack.a" ]
	then
		eerror "Could not find libcrack.a which is needed by core components!"
		die "Could not find libcrack.a which is needed by core components!"
	fi

	# This link is needed and not created. :| bug #9611
	cd ${D}/usr/lib
	dosym libcrack.so.2.7 /usr/lib/libcrack.so.2
	cd ${S}

	cp ${S}/cracklib/packer.h ${D}/usr/include
	#fix the permissions on it as they may be wrong in some cases
	fperms 644 usr/include/packer.h

	preplib /usr/lib

	dodoc HISTORY LICENCE MANIFEST POSTER README
}
