# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/clisp/clisp-2.31.ebuild,v 1.5 2004/03/30 20:58:13 spyderous Exp $

IUSE="X threads fastcgi postgres ldap nls"

DESCRIPTION="A portable, bytecode-compiled implementation of Common Lisp"
HOMEPAGE="http://clisp.sourceforge.net/"
SRC_URI="mirror://sourceforge/clisp/${P}.tar.bz2"
S=${WORKDIR}/${P}
DEPEND="dev-libs/libsigsegv
	dev-lisp/common-lisp-controller
	fastcgi? ( dev-libs/fcgi )
	postgres? ( dev-db/postgresql )
	X? ( virtual/x11 )
	ldap? ( net-nds/openldap )
	readline? ( sys-libs/readline )
	nls? ( sys-devel/gettext )"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="x86"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}/bindings-glibc-linux.lisp-gentoo.patch
	epatch ${FILESDIR}/${PV}/bindings-wildcard-fnmatch.c-gentoo.patch
	epatch ${FILESDIR}/${PV}/fastcgi-Makefile.in-gentoo.patch
}

src_compile() {
	export CC="${CC} ${CFLAGS}"
	unset CFLAGS CXXFLAGS
	local myconf="--with-dynamic-ffi
		--with-unicode
		--with-module=regexp
		--with-module=syscalls
		--with-module=wildcard
		--with-module=bindings/glibc"
	use readline || myconf="${myconf} --with-noreadline"
	use nls || myconf="${myconf} --with-nogettext"
	use X && myconf="${myconf} --with-module=clx/new-clx"
	use postgres && myconf="${myconf} --with-module=postgresql"
	use fastcgi && myconf="${myconf} --with-module=fastcgi"
	# the following modules are not supported
#	use ldap && myconf="${myconf} --with-module=dirkey"
#	use threads && myconf="${myconf} --with-threads=POSIX_THREADS"
	./configure --prefix=/usr ${myconf} build || die "./configure failed"
	cd build
	./makemake ${myconf} >Makefile
	make config.lisp
	sed 's,"vi","nano",g' <config.lisp >config.gentoo && mv config.gentoo config.lisp || die
	make || die
}

src_install() {
	cd build && make DESTDIR=${D} prefix=/usr install-bin || die

	doman clisp.1
	dodoc SUMMARY README* NEWS MAGIC.add GNU-GPL COPYRIGHT \
		ANNOUNCE clisp.dvi clisp.html

	rm -f ${D}/usr/lib/clisp/base/*
	(cd ${D}/usr/lib/clisp/base && ln -s ../full/* .)
	chmod a+x ${D}/usr/lib/clisp/clisp-link

	# install common-lisp-controller profile
	exeinto /usr/lib/common-lisp/bin
	doexe ${FILESDIR}/clisp.sh
	insinto /usr/lib/clisp
	doins ${FILESDIR}/install-clc.lisp

	keepdir /usr/lib/common-lisp/clisp
}

pkg_preinst() {
	local clisp_dir=/usr/lib/clisp
	local old_mem=$clisp_dir/full/lispinit.mem
	local new_mem=$clisp_dir/full/lispinit-new.mem
	local clean_mem=$clisp_dir/full/lispinit-clean.mem
	local lisp_run=$clisp_dir/full/lisp.run

	rm -f $old_mem $new_mem $clean_mem $lisp_run
}

pkg_postinst() {
	chown cl-builder:cl-builder /usr/lib/common-lisp/clisp
	rm -rf /usr/lib/common-lisp/clisp/*
	/usr/bin/clc-autobuild-impl clisp yes
	/usr/sbin/register-common-lisp-implementation clisp
}

pkg_prerm() {
	rm -rf /usr/lib/common-lisp/clisp/*
}

