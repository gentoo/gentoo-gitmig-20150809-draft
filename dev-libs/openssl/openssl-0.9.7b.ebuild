# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/openssl/openssl-0.9.7b.ebuild,v 1.10 2004/01/17 07:26:29 kumba Exp $

inherit eutils

S=${WORKDIR}/${P}
DESCRIPTION="Toolkit for SSL v2/v3 and TLS v1"
SRC_URI="mirror://openssl/source/${P}.tar.gz"
HOMEPAGE="http://www.openssl.org/"

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND} >=dev-lang/perl-5"
LICENSE="as-is"
SLOT="0"
#amd64 needs this version or later.
KEYWORDS="amd64"

warning() {
	ewarn "BIG FAT WARNING!!!"
	ewarn "You must re-emerge every package that links to openssl after you have merged ${P}"
	ewarn "This is becuse packages that links against ${PN} links against the full version"
	ewarn "Also, if you don't have the sources for the packages you need to re-emerge you"
	ewarn "should download them with emerge -f prior to the installation of ${P}."
	ewarn "This is becuse wget may be linked against ${PN}."
	ewarn "To generate a list of packages that links against ${PN} you can download"
	ewarn "and run the script from http://dev.gentoo.org/~aliz/openssl_update.sh"
	ewarn "If you are using binary packages you need to rebuild those against the"
	ewarn "new version of ${PN}"
	sleep 10
}

src_unpack() {
	warning
	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/${PN}-0.9.7a-gentoo.diff

	if [ "${ARCH}" = "hppa" ]; then
	sed -e \
	's!^"linux-parisc"\(.*\)::BN\(.*\)::!"linux-parisc"\1:-ldl:BN\2::::::::::dlfcn:linux-shared:-fPIC::.so.\\$(SHLIB_MAJOR).\\$(SHLIB_MINOR)!' \
		Configure > Configure.orig
	else
		cp Configure Configure.orig
	fi
	if [ "${ARCH}" = "alpha" -a "${CC}" != "ccc" ]; then
	# ccc compiled openssl will break things linked against
	# a gcc compiled openssl, the configure will automatically detect 
	# ccc and use it, so stop that if user hasnt asked for it.
		sed -e \
			's!CC=ccc!CC=gcc!' config > config.orig
		cp config.orig config
	fi

	sed -e "s/-O3/$CFLAGS/" -e "s/-m486//" Configure.orig > Configure
}

src_compile() {
	./config --prefix=/usr --openssldir=/etc/ssl shared threads || die
	# i think parallel make has problems
	make all || die
}

src_install() {
	make INSTALL_PREFIX=${D} MANDIR=/usr/share/man install || die
	dodoc CHANGES* FAQ LICENSE NEWS README
	dodoc doc/*.txt
	dohtml doc/*
	insinto /usr/share/emacs/site-lisp
	doins doc/c-indentation.el

	# The man pages rand.3 and passwd.1 conflict with other packages
	# Rename them to ssl-* and also make a symlink from openssl-* to ssl-*
	cd ${D}/usr/share/man/man1
	mv passwd.1 ssl-passwd.1
	ln -sf ssl-passwd.1 openssl-passwd.1
	cd ${D}/usr/share/man/man3
	mv rand.3 ssl-rand.3
	ln -sf ssl-rand.3 openssl-rand.3

	# create the certs directory.  Previous openssl builds
	# would need to create /usr/lib/ssl/certs but this looks
	# to be the more FHS compliant setup... -raker
	dodir /etc/ssl/certs

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
}

