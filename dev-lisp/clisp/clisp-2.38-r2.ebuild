# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/clisp/clisp-2.38-r2.ebuild,v 1.2 2006/04/24 20:41:58 mkennedy Exp $

inherit flag-o-matic common-lisp-common-2 eutils toolchain-funcs

DESCRIPTION="A portable, bytecode-compiled implementation of Common Lisp"
HOMEPAGE="http://clisp.sourceforge.net/"
SRC_URI="mirror://sourceforge/clisp/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~ppc ~ppc-macos -sparc ~x86"
IUSE="X new-clx fastcgi pcre postgres readline zlib"

RDEPEND="dev-libs/libsigsegv
	>=dev-lisp/common-lisp-controller-4.27
	sys-devel/gettext
	virtual/tetex
	fastcgi? ( dev-libs/fcgi )
	postgres? ( >=dev-db/postgresql-8.0 )
	readline? ( sys-libs/readline )
	pcre? ( dev-libs/libpcre )
	zlib? ( sys-libs/zlib )
	X? ( new-clx? ( || ( x11-libs/libXpm virtual/x11 ) ) )"

DEPEND="${RDEPEND}
	X? ( new-clx? ( || ( ( x11-misc/imake x11-proto/xextproto ) virtual/x11 ) ) )"

PROVIDE="virtual/commonlisp"

pkg_setup() {
	if use X; then
		if use new-clx; then
			einfo "CLISP will be built with NEW-CLX support which is a C binding to Xorg libraries."
		else
			einfo "CLISP will be built with MIT-CLX support."
		fi
	fi
}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}/fastcgi-Makefile-gentoo.patch
}

src_compile() {
	# Let CLISP use its own set of optimizations
	unset CFLAGS CXXFLAGS
	CC="$(tc-getCC)"
	local myconf="--with-dynamic-ffi
		--with-module=wildcard
		--with-module=rawsock"
	use ppc-macos || myconf="${myconf} --with-module=bindings/glibc"
	use readline || myconf="${myconf} --with-noreadline"
	if use X; then
		if use new-clx; then
			myconf="${myconf} --with-module=clx/new-clx"
		else
			myconf="${myconf} --with-module=clx/mit-clx"
		fi
	fi
	if use postgres; then
		myconf="${myconf} --with-module=postgresql"
		CC="${CC} -I $(pg_config --includedir)"
	fi
	use fastcgi && myconf="${myconf} --with-module=fastcgi"
	use pcre && myconf="${myconf} --with-module=pcre"
	use zlib && myconf="${myconf} --with-module=zlib"
	einfo "Configuring with ${myconf}"
	./configure --prefix=/usr ${myconf} build || die "./configure failed"
	cd build
	./makemake ${myconf} >Makefile
	emake -j1 config.lisp
	sed -i 's,"vi","nano",g' config.lisp
	sed -i 's,http://www.lisp.org/HyperSpec/,http://www.lispworks.com/reference/HyperSpec/,g' config.lisp
	emake -j1 || die
}

src_install() {
	pushd build
	make DESTDIR=${D} prefix=/usr install-bin || die
	doman clisp.1
	dodoc SUMMARY README* NEWS MAGIC.add GNU-GPL COPYRIGHT \
		ANNOUNCE clisp.dvi clisp.html
	rm -f ${D}/usr/lib/clisp/base/*
	(cd ${D}/usr/lib/clisp/base && ln -s ../full/* .)
	chmod a+x ${D}/usr/lib/clisp/clisp-link
	popd
	# install common-lisp-controller profile
	exeinto /usr/lib/common-lisp/bin
	doexe ${FILESDIR}/${PV}/clisp.sh
	insinto /usr/lib/clisp
	doins ${FILESDIR}/${PV}/install-clc.lisp
	dodoc ${FILESDIR}/${PV}/README.Gentoo
	keepdir /usr/lib/common-lisp/clisp

	dohtml doc/impnotes.{css,html}
	dohtml build/clisp.html
	dohtml doc/clisp.png
	dodoc build/clisp.{ps,pdf}
	dodoc doc/{editors,CLOS-guide,LISP-tutorial}.txt
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
	standard-impl-postinst clisp
}

pkg_postrm() {
	standard-impl-postrm clisp /usr/bin/clisp
}

pkg_postrm() {
	if [ ! -x /usr/bin/clisp ]; then
		rm -rf /usr/lib/clisp/ || die
	fi
}
