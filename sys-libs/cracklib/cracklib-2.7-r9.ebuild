# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/cracklib/cracklib-2.7-r9.ebuild,v 1.9 2004/07/21 20:33:06 mr_bones_ Exp $

inherit flag-o-matic eutils

MY_P=${P/-/,}
DESCRIPTION="Password Checking Library"
HOMEPAGE="http://www.crypticide.org/users/alecm/"
SRC_URI="http://www.crypticide.org/users/alecm/security/${MY_P}.tar.gz"

LICENSE="CRACKLIB"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips alpha arm ~hppa amd64 ia64 ~ppc64 s390"
IUSE="pam uclibc"

RDEPEND="sys-apps/miscfiles
	>=sys-apps/portage-2.0.47-r10"
DEPEND="${RDEPEND}
	uclibc? ( app-arch/gzip )
	sys-devel/gcc-config"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-redhat.patch
	epatch ${FILESDIR}/${P}-gentoo-new.diff
	epatch ${FILESDIR}/${P}-static-lib.patch

	# add compressed dict support, taken from shadow-4.0.4.1
	use uclibc && epatch ${FILESDIR}/${PN}-${PV}-gzip.patch

	sed -i \
		-e 's|/usr/dict/words|/usr/share/dict/words|' \
		util/create-cracklib-dict \
		|| die "sed util/create-cracklib-dict failed"

	if [ "${ARCH}" = "alpha" -a "${CC}" = "ccc" ] ; then
		sed -i \
			-e 's:CFLAGS += -g :CFLAGS += -g3 :' ${S}/cracklib/Makefile \
			|| die "sed ${S}/cracklib/Makefile failed"
	fi
}

src_compile() {
	emake all || die "emake failed"
}

src_install() {
	dodir /usr/{lib,sbin,include} /lib
	keepdir /usr/share/cracklib

	make DESTDIR="${D}" install || die "make install failed"

	# Needed by pam
	if [ ! -f "${D}/usr/lib/libcrack.a" ] && use pam
	then
		eerror "Could not find libcrack.a which is needed by core components!"
		die "Could not find libcrack.a which is needed by core components!"
	fi

	# correct permissions on static lib
	[ -x ${D}/usr/lib/libcrack.a ] && fperms 644 usr/lib/libcrack.a

	# put libcrack.so.2.7 in /lib for cases where /usr isn't available yet
	mv ${D}/usr/lib/libcrack.so* ${D}/lib

	# This link is needed and not created. :| bug #9611
	cd ${D}/lib
	dosym libcrack.so.2.7 /lib/libcrack.so.2

	# remove it, if not needed
	use pam || rm -f ${D}/usr/lib/libcrack.a

	cd ${S}

	cp ${S}/cracklib/packer.h ${D}/usr/include
	#fix the permissions on it as they may be wrong in some cases
	fperms 644 usr/include/packer.h

	preplib /usr/lib /lib

	dodoc HISTORY LICENCE MANIFEST POSTER README
}
