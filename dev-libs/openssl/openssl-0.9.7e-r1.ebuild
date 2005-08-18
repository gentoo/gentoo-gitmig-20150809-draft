# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/openssl/openssl-0.9.7e-r1.ebuild,v 1.17 2005/08/18 00:13:17 vapier Exp $

inherit eutils flag-o-matic toolchain-funcs

OLD_096_P="${PN}-0.9.6m"

DESCRIPTION="Toolkit for SSL v2/v3 and TLS v1"
HOMEPAGE="http://www.openssl.org/"
SRC_URI="mirror://openssl/source/${P}.tar.gz
	mirror://openssl/source/${OLD_096_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE="emacs test bindist zlib"

RDEPEND=""
DEPEND="${RDEPEND}
	sys-apps/diffutils
	>=dev-lang/perl-5
	!test? ( sys-devel/bc )"

S=${WORKDIR}

src_unpack() {
	unpack ${A}

	# openssl-0.9.7
	cd ${WORKDIR}/${P}

	epatch "${FILESDIR}"/${PN}-0.9.7c-tempfile.patch
	[[ $(tc-arch) == "ppc64" ]] && epatch "${FILESDIR}"/addppc64support.diff
	epatch "${FILESDIR}"/${PN}-0.9.7e-gentoo.patch
	epatch "${FILESDIR}"/${PN}-0.9.7-arm-big-endian.patch
	epatch "${FILESDIR}"/${PN}-0.9.7-hppa-fix-detection.patch
	epatch "${FILESDIR}"/${PN}-0.9.7-alpha-default-gcc.patch
	epatch "${FILESDIR}"/${PN}-0.9.7e-no-fips.patch
	epatch "${FILESDIR}"/${PN}-0.9.7e-ptr-casting.patch
	epatch "${FILESDIR}"/${PN}-0.9.7g-mem-clr-ptr-cast.patch
	epatch "${FILESDIR}"/${PN}-0.9.7e-x86_64-bn-asm.patch

	case $(gcc-version) in
		3.2)
			filter-flags -fprefetch-loop-arrays -freduce-all-givs -funroll-loop
		;;
		3.4 | 3.3 )
			filter-flags -fprefetch-loop-arrays -freduce-all-givs -funroll-loops
			[[ ${ARCH} == "ppc" ||  ${ARCH} == "ppc64" ]] && append-flags -fno-strict-aliasing
			# <robbat2@gentoo.org> (14 Feb 2004)
			# bug #69550 openssl breaks in some cases.
			[[ ${ARCH} == "x86" ]] && append-flags -Wa,--noexecstack
		;;
	esac

	# replace CFLAGS
	OLDIFS=$IFS
	IFS=$'\n'
	for a in $( grep -n -e "^\"linux-" Configure ); do
		LINE=$( echo $a | awk -F: '{print $1}' )
		CUR_CFLAGS=$( echo $a | awk -F: '{print $3}' )
		# for ppc64 I have to be careful given current toolchain issues
		if [[ ${ARCH} != "ppc64" ]]; then
			NEW_CFLAGS="$( echo $CUR_CFLAGS | sed -r -e "s|-O[23]||" -e "s:-fomit-frame-pointer::" -e "s:-mcpu=[-a-z0-9]+::" -e "s:-m486::" ) $CFLAGS"
		else
			NEW_CFLAGS="$( echo $CUR_CFLAGS | sed -r -e "s|-O[23]||" -e "s:-fomit-frame-pointer::" -e "s:-mcpu=[-a-z0-9]+::" -e "s:-m486::" ) "

		fi

		sed -i "${LINE}s:$CUR_CFLAGS:$NEW_CFLAGS:" Configure \
		|| die "sed failed"
	done
	IFS=$OLDIFS

	if [ "$(get_libdir)" != "lib" ] ; then
		# using a library directory other than lib requires some magic
		sed -i \
			-e "s+\(\$(INSTALL_PREFIX)\$(INSTALLTOP)\)/lib+\1/$(get_libdir)+g" \
			-e "s+libdir=\$\${exec_prefix}/lib+libdir=\$\${exec_prefix}/$(get_libdir)+g" \
			Makefile.org \
			|| die "sed failed"
		./config --test-sanity || die "sanity failed"
	fi

	# openssl-0.9.6
	test -f ${ROOT}/usr/lib/libssl.so.0.9.6 && {
		cd ${WORKDIR}/${OLD_096_P}

		epatch "${FILESDIR}"/${OLD_096_P}-gentoo.diff

		case ${ARCH} in
		mips)
			epatch "${FILESDIR}"/openssl-0.9.6-mips.diff
		;;
		arm)
			# patch linker to add -ldl or things linking aginst libcrypto fail
			sed -i -e \
				's!^"linux-elf-arm"\(.*\)::BN\(.*\)!"linux-elf-arm"\1:-ldl:BN\2!' \
				Configure \
				|| die "sed failed"
		;;
		hppa)
			# Tells to compile a static version of openssl
			sed -i -e \
				's!^"linux-parisc"\(.*\)::BN\(.*\)::!"linux-parisc"\1:-ldl:BN\2::::::::::dlfcn:linux-shared:-fPIC::.so.\\$(SHLIB_MAJOR).\\$(SHLIB_MINOR)!' \
				Configure \
				|| die "sed failed"
			# Fix detection of parisc running 64 bit kernel
			sed -i -e 's/parisc-\*-linux2/parisc\*-\*-linux2/' config \
			|| die "sed failed"
		esac

		# replace CFLAGS
		OLDIFS=$IFS
		IFS=$'\n'
		for a in $( grep -n -e "^\"linux-" Configure ); do
	  		LINE=$( echo $a | awk -F: '{print $1}' )
	  		CUR_CFLAGS=$( echo $a | awk -F: '{print $3}' )
	  		NEW_CFLAGS="$( echo $CUR_CFLAGS | sed -r -e "s|-O[23]||" -e "s/-fomit-frame-pointer//" -e "s/-mcpu=[-a-z0-9]+//" -e "s/-m486//" ) $CFLAGS"
	  		sed -i "${LINE}s/$CUR_CFLAGS/$NEW_CFLAGS/" Configure \
			|| die "sed failed"
		done
		IFS=$OLDIFS
	}
}

src_compile() {
	# openssl-0.9.7
	cd ${WORKDIR}/${P}

	# Clean out patent-or-otherwise-encumbered code.
	# MDC-2: 4,908,861 13/03/2007
	# IDEA:  5,214,703 25/05/2010
	# RC5:   5,724,428 03/03/2015
	# EC:    ????????? ??/??/2015
	use bindist && conf_options="no-idea no-rc5 no-mdc2 -no-ec"

	use zlib && conf_options="${conf_options} zlib-dynamic"

	# Build correctly for mips, mips64, & mipsel
	if use mips; then
		if [[ ${CHOST/mipsel} != ${CHOST} ]] ; then
			mipsarch="linux-mipsel"
		else
			mipsarch="linux-mips"
		fi

		./Configure ${mipsarch} ${conf_options} --prefix=/usr --openssldir=/etc/ssl \
			shared threads || die
	# force sparcv8 on sparc32 profile
	elif [ "$PROFILE_ARCH" = "sparc" ]; then
		./Configure linux-sparcv8 ${conf_options} --prefix=/usr --openssldir=/etc/ssl \
			shared threads || die
	elif [ "${ABI}" = "sparc64" ]; then
		./Configure linux64-sparcv9 ${conf_options} --prefix=/usr --openssldir=/etc/ssl \
			shared threads || die
	else
		./config ${conf_options} --prefix=/usr --openssldir=/etc/ssl shared threads \
			|| die "config failed"
	fi

	einfo "Compiling ${P}"
	make CC="$(tc-getCC)" all || die "make all failed"

	# openssl-0.9.6
	test -f ${ROOT}/usr/lib/libssl.so.0.9.6 && {
		cd ${WORKDIR}/${OLD_096_P}

		# force sparcv8 on sparc32 profile
		if [ "$PROFILE_ARCH" = "sparc" ]; then
			SSH_TARGET="linux-sparcv8"
		elif [ "`uname -m`" = "parisc" -o "`uname -m`" = "parisc64" ]; then
			SSH_TARGET="linux-parisc"
		elif use mips; then
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
		make CC="$(tc-getCC)" all || die
	}
}

src_test() {
	cd ${WORKDIR}/${P}
	make test || die "make test failed"

	# openssl-0.9.6
	test -f ${ROOT}/usr/lib/libssl.so.0.9.6 && {
		cd ${WORKDIR}/${OLD_096_P}
		make all || die
	}
}

src_install() {
	# openssl-0.9.7
	cd ${WORKDIR}/${P}
	make INSTALL_PREFIX=${D} MANDIR=/usr/share/man install || die
	dodoc CHANGES* FAQ NEWS README
	dodoc doc/*.txt
	dohtml doc/*

	if use emacs ; then
		insinto /usr/share/emacs/site-lisp
		doins doc/c-indentation.el
	fi

	# create the certs directory.  Previous openssl builds
	# would need to create /usr/lib/ssl/certs but this looks
	# to be the more FHS compliant setup... -raker
	insinto /etc/ssl/certs
	doins certs/*.pem
	LD_LIBRARY_PATH="${D}"/usr/$(get_libdir)/ \
	OPENSSL=${D}/usr/bin/openssl /usr/bin/perl tools/c_rehash ${D}/etc/ssl/certs

	# These man pages with other packages so rename them
	cd "${D}"/usr/share/man
	for m in man1/passwd.1 man3/rand.3 man3/err.3 ; do
		d=${m%%/*} ; m=${m##*/}
		mv ${d}/{,ssl-}${m}
		ln -s ssl-${m} ${d}/openssl-${m}
	done

	# openssl-0.9.6
	test -f ${ROOT}/usr/lib/libssl.so.0.9.6 && {
		cd ${WORKDIR}/${OLD_096_P}
		make || die
		dolib.so ${WORKDIR}/${OLD_096_P}/libcrypto.so.0.9.6||die "libcrypto.so.0.9.6 not found"
		dolib.so ${WORKDIR}/${OLD_096_P}/libssl.so.0.9.6|| die "libssl.so.0.9.6 not found"
	}
	fperms a+x /usr/$(get_libdir)/pkgconfig #34088
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


	ewarn "If you do not etc-update now and update /etc/ssl/misc/der_chop to the new version, your"
	ewarn "system IS VULNERABLE to a symlink attack as described in bug 68407"
	ewarn "refer to http://bugs.gentoo.org/show_bug.cgi?id=68407 if you have any doubts"
}
