# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/clisp/clisp-2.30-r1.ebuild,v 1.4 2004/03/30 20:58:13 spyderous Exp $

IUSE="X threads"

DESCRIPTION="A portable, bytecode-compiled implementation of Common Lisp"
HOMEPAGE="http://clisp.sourceforge.net/"
SRC_URI="mirror://sourceforge/clisp/${P}.tar.bz2"
S=${WORKDIR}/${P}
DEPEND="X? ( virtual/x11 )
	dev-lisp/common-lisp-controller"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86 ~ppc"

src_unpack() {
	unpack ${A}
	cd ${S} && patch -p1 <${FILESDIR}/${P}-gentoo.patch || die
	cd ${S} && patch -p2 <${FILESDIR}/${P}-linux.lisp-upstream.patch || die
}

src_compile() {
	local myconf="--with-dynamic-ffi
		--with-dynamic-modules
		--with-export-syscalls
		--with-module=wildcard
		--with-module=regexp
		--with-module=bindings/linuxlibc6"

# for the time being, these modules cause segv during build
	use X && myconf="${myconf} --with-module=clx/new-clx"
# 	use threads && myconf="${myconf} --with-threads=POSIX_THREADS"

	einfo "Configuring with $myconf"
	./configure --prefix=/usr ${myconf} || die "./configure failed"
	cd src && ./makemake ${myconf} > Makefile
	make config.lisp
	make || die
}

src_install() {
	cd src && make DESTDIR=${D} prefix=/usr install-bin || die
	doman clisp.1 clreadline.3
	dodoc SUMMARY README* NEWS MAGIC.add GNU-GPL COPYRIGHT \
		ANNOUNCE clisp.dvi clisp.html clreadline.dvi clreadline.html

	rm -f ${D}/usr/lib/clisp/base/*
	(cd ${D}/usr/lib/clisp/base && ln -s ../full/* .)
	chmod a+x ${D}/usr/lib/clisp/clisp-link

	# install common-lisp-controller profile
	exeinto /usr/lib/common-lisp/bin
	doexe ${FILESDIR}/clisp.sh
	insinto /usr/lib/clisp
	doins ${FILESDIR}/install-clc.lisp
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
	/usr/sbin/register-common-lisp-implementation clisp
}

pkg_prerm() {
	/usr/sbin/unregister-common-lisp-implementation clisp
}

