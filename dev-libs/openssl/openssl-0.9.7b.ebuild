# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/openssl/openssl-0.9.7b.ebuild,v 1.2 2003/04/17 11:22:05 taviso Exp $

inherit eutils

S=${WORKDIR}/${P}
DESCRIPTION="Toolkit for SSL v2/v3 and TLS v1"
SRC_URI="http://www.openssl.org/source/${P}.tar.gz"
HOMEPAGE="http://www.openssl.org/"

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND} >=dev-lang/perl-5"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa"

warning() {
	ewarn "BIG FAT WARNING!!!"
	ewarn "You must re-emerge every package that links to openssl after you have merged ${P}"
	ewarn "This is becuse packages that links against ${PN} links against the full version"
	ewarn "Also, if you don't have the sources for the packages you need to re-emerge you"
	ewarn "should download them with emerge -f prior to the installation of ${P}."
	ewarn "This is becuse wget may be linked against ${PN}."
	ewarn "To generate a list of packages that links against ${PN} you can download"
	ewarn "and run the script from http://cvs.gentoo.org/~aliz/openssl_update.sh"
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
	elif [ "${ARCH}" = "alpha" ]; then
		# ccc users still need shared libraries.
		sed -e \
		's!^"linux-alpha-ccc"\(.*\)\${alpha_asm}!"linux-alpha-ccc"\1\${alpha_asm}:dlfcn:linux-shared:-fPIC::.so.\\$(SHLIB_MAJOR).\\$(SHLIB_MINOR)!
		s!^"linux-alpha+bwx-ccc"\(.*\)\${alpha_asm}!"linux-alpha+bwx-ccc"\1\${alpha_asm}:dlfcn:linux-shared:-fPIC::.so.\\$(SHLIB_MAJOR).\\$(SHLIB_MINOR)!' \
		Configure > Configure.orig
	else
		cp Configure Configure.orig
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

}

