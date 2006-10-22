# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/openssl/openssl-0.9.7l.ebuild,v 1.13 2006/10/22 11:41:24 vapier Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Toolkit for SSL v2/v3 and TLS v1"
HOMEPAGE="http://www.openssl.org/"
SRC_URI="mirror://openssl/source/${P}.tar.gz"

LICENSE="openssl"
SLOT="0"
KEYWORDS="-* alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 ~s390 ~sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="emacs test bindist zlib"

RDEPEND=""
DEPEND="${RDEPEND}
	sys-apps/diffutils
	>=dev-lang/perl-5
	test? ( sys-devel/bc )"
PDEPEND="app-misc/ca-certificates"

src_unpack() {
	unpack ${A}

	cd "${S}"

	epatch "${FILESDIR}"/${PN}-0.9.7g-ppc64.patch
	epatch "${FILESDIR}"/${PN}-0.9.7e-gentoo.patch
	epatch "${FILESDIR}"/${PN}-0.9.7-hppa-fix-detection.patch
	epatch "${FILESDIR}"/${PN}-0.9.7-alpha-default-gcc.patch
	epatch "${FILESDIR}"/${PN}-0.9.7g-mem-clr-ptr-cast.patch
	epatch "${FILESDIR}"/${PN}-0.9.7h-ABI-compat.patch
	epatch "${FILESDIR}"/${PN}-0.9.7g-superh.patch
	epatch "${FILESDIR}"/${PN}-0.9.7i-m68k.patch
	epatch "${FILESDIR}"/${PN}-0.9.7g-amd64-fbsd.patch
	epatch "${FILESDIR}"/${PN}-0.9.7j-doc-updates.patch

	# allow openssl to be cross-compiled
	cp "${FILESDIR}"/gentoo.config-0.9.7g gentoo.config || die "cp cross-compile failed"
	chmod a+rx gentoo.config

	# Don't build manpages if we don't want them
	has noman FEATURES && sed -i '/^install:/s:install_docs::' Makefile.org

	case $(gcc-version) in
		3.2)
			filter-flags -fprefetch-loop-arrays -freduce-all-givs -funroll-loop
		;;
		3.4 | 3.3 )
			filter-flags -fprefetch-loop-arrays -freduce-all-givs -funroll-loops
			[[ ${ARCH} == "ppc" ||  ${ARCH} == "ppc64" ]] && append-flags -fno-strict-aliasing
		;;
	esac
	append-flags -Wa,--noexecstack

	# replace CFLAGS
	OLDIFS=$IFS
	IFS=$'\n'
	for a in $( grep -n -e "^\"linux-" Configure ); do
		LINE=$( echo $a | awk -F: '{print $1}' )
		CUR_CFLAGS=$( echo $a | awk -F: '{print $3}' )
		NEW_CFLAGS=$(echo $CUR_CFLAGS | LC_ALL=C sed -r -e "s|-O[23]||" -e \
		"s:-fomit-frame-pointer::" -e "s:-mcpu=[-a-z0-9]+::" -e "s:-m486::" \
		-e "s:-mv8::")
		# ppc64's current toolchain sucks at optimization and will break this package
		[[ $(tc-arch) != "ppc64" ]] && NEW_CFLAGS="${NEW_CFLAGS} ${CFLAGS}"

		sed -i "${LINE}s:$CUR_CFLAGS:$NEW_CFLAGS:" Configure || die "sed failed"
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
}

src_compile() {
	# Clean out patent-or-otherwise-encumbered code.
	# MDC-2: 4,908,861 13/03/2007
	# IDEA:  5,214,703 25/05/2010
	# RC5:   5,724,428 03/03/2015
	# EC:    ????????? ??/??/2015
	local confopts=""
	use bindist && confopts="no-idea no-rc5 no-mdc2 -no-ec"

	use zlib && confopts="${confopts} zlib-dynamic"

	local sslout=$(./gentoo.config)
	einfo "Use configuration ${sslout}"

	local config="Configure"
	[[ -z ${sslout} ]] && config="config"
	./${config} \
		${sslout} \
		${confopts} \
		--prefix=/usr \
		--openssldir=/etc/ssl \
		shared threads \
		|| die "Configure failed"

	emake \
		CC="$(tc-getCC)" MAKEDEPPROG="$(tc-getCC)" \
		AR="$(tc-getAR) r" \
		RANLIB="$(tc-getRANLIB)" \
		all || die "make all failed"
}

src_test() {
	# make sure sandbox doesnt die on *BSD
	addpredict /dev/crypto

	make test || die "make test failed"
}

src_install() {
	emake \
		CC="$(tc-getCC)" MAKEDEPPROG="$(tc-getCC)" \
		AR="$(tc-getAR) r" \
		RANLIB="$(tc-getRANLIB)" \
		INSTALL_PREFIX="${D}" MANDIR=/usr/share/man install || die
	dodoc CHANGES* FAQ NEWS README doc/*.txt
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
	OPENSSL="${D}"/usr/bin/openssl /usr/bin/perl tools/c_rehash "${D}"/etc/ssl/certs

	# Namespace openssl programs to prevent conflicts with other man pages
	cd "${D}"/usr/share/man
	local m d s
	for m in $(find . -type f -printf '%P ' | xargs grep -L '#include') ; do
		d=${m%/*} ; m=${m##*/}
		mv ${d}/{,ssl-}${m}
		ln -s ssl-${m} ${d}/openssl-${m}
		# locate any symlinks that point to this man page
		for s in $(find ${d} -lname ${m}) ; do
			s=${s##*/}
			rm -f ${d}/${s}
			ln -s ssl-${m} ${d}/ssl-${s}
			ln -s ssl-${s} ${d}/openssl-${s}
		done
	done

	diropts -m0700
	keepdir /etc/ssl/private

	fperms a+x /usr/$(get_libdir)/pkgconfig #34088
}

pkg_postinst() {
	if [[ -e ${ROOT}/usr/lib/libcrypto.so.0.9.6 ]] ; then
		ewarn "You must re-compile all packages that are linked against"
		ewarn "OpenSSL 0.9.6 by using revdep-rebuild from gentoolkit:"
		ewarn "# revdep-rebuild --library libssl.so.0.9.6"
		ewarn "# revdep-rebuild --library libcrypto.so.0.9.6"
		ewarn "After this, you can delete /usr/lib/libssl.so.0.9.6 and /usr/lib/libcrypto.so.0.9.6"
		touch -c "${ROOT}"/usr/lib/lib{crypto,ssl}.so.0.9.6
	fi
}
