# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/openssl/openssl-0.9.7c-r1.ebuild,v 1.20 2004/02/16 22:48:23 gustavoz Exp $

inherit eutils flag-o-matic

OLD_096_P="${PN}-0.9.6l"

S="${WORKDIR}"
DESCRIPTION="Toolkit for SSL v2/v3 and TLS v1"
SRC_URI="mirror://openssl/source/${P}.tar.gz
	mirror://openssl/source/${OLD_096_P}.tar.gz"
HOMEPAGE="http://www.openssl.org/"

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	>=sys-apps/sed-4"
LICENSE="as-is"
SLOT="0"

KEYWORDS="x86 ppc alpha sparc mips hppa ~arm amd64 ia64 ppc64"

src_unpack() {
	unpack ${A}

	# openssl-0.9.7
	cd ${WORKDIR}/${P}

	epatch ${FILESDIR}/${P}-gentoo.diff

	if [ "${ARCH}" = "hppa" ]; then
		# Tells to compile a static version of openssl
		sed -i -e \
		's!^"linux-parisc"\(.*\)::BN\(.*\)::!"linux-parisc"\1:-ldl:BN\2::::::::::dlfcn:linux-shared:-fPIC::.so.\\$(SHLIB_MAJOR).\\$(SHLIB_MINOR)!' \
		Configure
		# Fix detection of parisc running 64 bit kernel
		sed -i -e 's/parisc-\*-linux2/parisc\*-\*-linux2/' config
	fi
	if [ "${ARCH}" = "alpha" -a "${CC}" != "ccc" ]; then
	# ccc compiled openssl will break things linked against
	# a gcc compiled openssl, the configure will automatically detect 
	# ccc and use it, so stop that if user hasnt asked for it.
		sed -i -e \
			's!CC=ccc!CC=gcc!' config
	fi

	local gcc_version=$(gcc -dumpversion | cut -d. -f1,2)
	if [ "${gcc_version}" == "3.3" ] || [ "${gcc_version}" == "3.2" ] ; then
		filter-flags -fprefetch-loop-arrays -freduce-all-givs
	fi

	# replace CFLAGS
	OLDIFS=$IFS
	IFS="
"
	for a in $( grep -n -e "^\"linux-" Configure ); do
		LINE=$( echo $a | awk -F: '{print $1}' )
		CUR_CFLAGS=$( echo $a | awk -F: '{print $3}' )
		NEW_CFLAGS="$( echo $CUR_CFLAGS | sed -r -e "s|-O[23]||" -e "s/-fomit-frame-pointer//" -e "s/-mcpu=[-a-z0-9]+//" -e "s/-m486//" ) $CFLAGS"
		sed -i "${LINE}s/$CUR_CFLAGS/$NEW_CFLAGS/" Configure
	done
	IFS=$OLDIFS

	# openssl-0.9.6
	test -f ${ROOT}/usr/lib/libssl.so.0.9.6 && {
		cd ${WORKDIR}/${OLD_096_P}

	        epatch ${FILESDIR}/${OLD_096_P}-gentoo.diff

		case ${ARCH} in
		mips)
			epatch ${FILESDIR}/openssl-0.9.6-mips.diff
		;;
		arm)
			# patch linker to add -ldl or things linking aginst libcrypto fail
			sed -i -e \
				's!^"linux-elf-arm"\(.*\)::BN\(.*\)!"linux-elf-arm"\1:-ldl:BN\2!' \
				Configure
		;;
		hppa)
			# Tells to compile a static version of openssl
			sed -i -e \
				's!^"linux-parisc"\(.*\)::BN\(.*\)::!"linux-parisc"\1:-ldl:BN\2::::::::::dlfcn:linux-shared:-fPIC::.so.\\$(SHLIB_MAJOR).\\$(SHLIB_MINOR)!' \
				Configure
			# Fix detection of parisc running 64 bit kernel
			sed -i -e 's/parisc-\*-linux2/parisc\*-\*-linux2/' config
		esac

		# replace CFLAGS
		OLDIFS=$IFS
		IFS="
"
		for a in $( grep -n -e "^\"linux-" Configure ); do
	  		LINE=$( echo $a | awk -F: '{print $1}' )
	  		CUR_CFLAGS=$( echo $a | awk -F: '{print $3}' )
	  		NEW_CFLAGS="$( echo $CUR_CFLAGS | sed -r -e "s|-O[23]||" -e "s/-fomit-frame-pointer//" -e "s/-mcpu=[-a-z0-9]+//" -e "s/-m486//" ) $CFLAGS"
	  		sed -i "${LINE}s/$CUR_CFLAGS/$NEW_CFLAGS/" Configure
		done
		IFS=$OLDIFS
	}
}

src_compile() {
	# openssl-0.9.7
	cd ${WORKDIR}/${P}

	# Build correctly for mips, mips64, & mipsel
	if [ "`use mips`" ]; then
		if [ "`echo ${CHOST} | grep "mipsel"`" ]; then
			mipsarch="linux-mipsel"
		else
			mipsarch="linux-mips"
		fi

		./Configure ${mipsarch} --prefix=/usr --openssldir=/etc/ssl \
			shared threads || die
	# We have to force the target for hppa because detection
	# is broken on SMP box
	elif [ "`uname -m`" = "parisc" -o "`uname -m`" = "parisc64" ]; then
		./Configure linux-parisc --prefix=/usr --openssldir=/etc/ssl \
			shared threads || die
	# force sparcv8 on sparc32 profile
	elif [ "$PROFILE_ARCH" = "sparc" ]; then
		./Configure linux-sparcv8 --prefix=/usr --openssldir=/etc/ssl \
			shared threads || die
	else
		./config --prefix=/usr --openssldir=/etc/ssl shared threads || die
	fi

	einfo "Compiling ${P}"
	make all || die
	make test || die

	# openssl-0.9.6
	test -f ${ROOT}/usr/lib/libssl.so.0.9.6 && {
		cd ${WORKDIR}/${OLD_096_P}

		# force sparcv8 on sparc32 profile
		if [ "$PROFILE_ARCH" = "sparc" ]; then
			SSH_TARGET="linux-sparcv8"
		elif [ "`uname -m`" = "parisc" -o "`uname -m`" = "parisc64" ]; then
			SSH_TARGET="linux-parisc"
		elif [ "`use mips`" ]; then
			if [ "`echo ${CHOST} | grep "mipsel"`" ]; then
				SSH_TARGET="linux-mipsel"
			else
				SSH_TARGET="linux-mips"
			fi
		fi

		case ${CHOST} in
		alphaev56*|alphaev6*)
			SSH_TARGET="linux-alpha+bwx-${CC:-gcc}"
		;;
		alpha*)
			SSH_TARGET="linux-alpha-${CC:-gcc}" ;;
		esac

		if [ ${SSH_TARGET} ]; then
			einfo "Forcing ${SSH_TARGET} compile"
			./Configure ${SSH_TARGET} --prefix=/usr \
				--openssldir=/etc/ssl shared threads || die
		else
			./config --prefix=/usr --openssldir=/etc/ssl shared threads || die
		fi

		einfo "Compiling ${OLD_096_P}"
		make all || die
		make test || die
	}
}

src_install() {
	# openssl-0.9.7
	cd ${WORKDIR}/${P}
	make INSTALL_PREFIX=${D} MANDIR=/usr/share/man install || die
	dodoc CHANGES* FAQ LICENSE NEWS README
	dodoc doc/*.txt
	dohtml doc/*
	insinto /usr/share/emacs/site-lisp
	doins doc/c-indentation.el

	# create the certs directory.  Previous openssl builds
	# would need to create /usr/lib/ssl/certs but this looks
	# to be the more FHS compliant setup... -raker
	insinto /etc/ssl/certs
	doins certs/*.pem
	OPENSSL=${D}/usr/bin/openssl /usr/bin/perl tools/c_rehash ${D}/etc/ssl/certs

	# The man pages rand.3 and passwd.1 conflict with other packages
	# Rename them to ssl-* and also make a symlink from openssl-* to ssl-*
	cd ${D}/usr/share/man/man1
	mv passwd.1 ssl-passwd.1
	ln -sf ssl-passwd.1 openssl-passwd.1
	cd ${D}/usr/share/man/man3
	mv rand.3 ssl-rand.3
	ln -sf ssl-rand.3 openssl-rand.3

	# openssl-0.9.6
	test -f ${ROOT}/usr/lib/libssl.so.0.9.6 && {
		cd ${WORKDIR}/${OLD_096_P}
		make || die
		dolib.so ${WORKDIR}/${OLD_096_P}/libcrypto.so.0.9.6||die "libcrypto.so.0.9.6 not found"
		dolib.so ${WORKDIR}/${OLD_096_P}/libssl.so.0.9.6|| die "libssl.so.0.9.6 not found"
	}

	fperms a+x /usr/lib/pkgconfig #34088
}

pkg_postinst() {
	local BN_H="${ROOT}$(gcc-config -L)/include/openssl/bn.h"
	# Breaks things one some boxen, bug #13795.  The problem is that
	# if we have a 'gcc fixed' version in $(gcc-config -L) from 0.9.6,
	# then breaks as it was defined as 'int BN_mod(...)' and in 0.9.7 it
	# is a define with BN_div(...) - <azarah@gentoo.org> (24 Sep 2003)
	if [ -f "${BN_H}" ] && [ -n "$(grep '^int[[:space:]]*BN_mod(' "${BN_H}")" ]
	then
		rm -f "${BN_H}"
	fi

	test -f ${ROOT}/usr/lib/libssl.so.0.9.6 && {
		einfo "You can now re-compile all packages that are linked against"
		einfo "OpenSSL 0.9.6 by using revdep-rebuild from gentoolkit:"
		einfo "# revdep-rebuild --soname libssl.so.0.9.6"
		einfo "# revdep-rebuild --soname libcrypto.so.0.9.6"
		einfo "After this, you can delete /usr/lib/libssl.so.0.9.6 and /usr/lib/libcrypto.so.0.9.6"
	}
}
