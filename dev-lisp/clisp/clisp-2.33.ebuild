# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/clisp/clisp-2.33.ebuild,v 1.1 2004/03/21 07:15:01 mkennedy Exp $

inherit flag-o-matic common-lisp-common

IUSE="X fastcgi postgres nls berkdb pcre"

# Handle the case where the user has some other -falign-functions
# option set.  Bug 34630.

if ! is-flag '-falign-functions=4' \
	&& expr "$CFLAGS" : '.*\(-falign-functions=[[:digit:]]\+\)' >/dev/null; then
	CFLAGS=${CFLAGS/\
$(expr "$CFLAGS" : '.*\(-falign-functions=[[:digit:]]\+\)')/\
-falign-functions=4}
fi

# Fails to compile without -falign-functions=4 when -march=pentium4
# (or -march=pentium3, sometimes??) is defined.	 Bugs 33425 and 34630.

if (is-flag '-march=pentium4' || is-flag '-march=pentium3') \
	&& ! is-flag '-falign-functions=4'; then
	append-flags '-falign-functions=4'
fi

# Athlon XP users report problems with -O3 optimization.  In this
# block, we remove any optimization flag.  Depending on bug 34497. we
# may be able to reduce optimization to -O2.

if is-flag '-march=athlon-xp'; then
	filter-flags '-O*'
fi

DESCRIPTION="A portable, bytecode-compiled implementation of Common Lisp"
HOMEPAGE="http://clisp.sourceforge.net/"
SRC_URI="mirror://sourceforge/clisp/${P}.tar.bz2"
S=${WORKDIR}/${P}
DEPEND="dev-libs/libsigsegv
	dev-lisp/common-lisp-controller
	fastcgi? ( dev-libs/fcgi )
	postgres? ( dev-db/postgresql )
	X? ( x11-base/xfree )
	readline? ( sys-libs/readline )
	nls? ( sys-devel/gettext )
	berkdb? ( =sys-libs/db-4* )
	pcre? ( dev-libs/libpcre )"
LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}/fastcgi-Makefile.in-gentoo.patch
	epatch ${FILESDIR}/${PV}/berkely-db-configure-gentoo.patch.gz
}

src_compile() {
	einfo "Using CFLAGS: ${CFLAGS}"
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
	if use postgres; then
		myconf="${myconf} --with-module=postgresql"
		CC="${CC} -I $(pg_config --includedir)"
	fi
	use fastcgi && myconf="${myconf} --with-module=fastcgi"
	use berkdb && myconf="${myconf} --with-module=berkeley-db"
	use pcre && myconf="${myconf} --with-module=pcre"
	./configure --prefix=/usr ${myconf} build || die "./configure failed"
	cd build
	./makemake ${myconf} >Makefile
	make config.lisp
	sed -i 's,"vi","nano",g' config.lisp
	sed -i 's,http://www.lisp.org/HyperSpec/,http://www.lispworks.com/reference/HyperSpec/,g' config.lisp
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
	standard-impl-postinst clisp
	while read line; do einfo "${line}"; done <<EOF

PLEASE NOTE: FASL files (.fas) created by previous versions of CLISP
are not compatible with this version of CLISP (${PV}).	You will need
to re-create your FASLs via. recompilation.	 FASLs in
/usr/lib/common-lisp/clisp for Common Lisp Controller-installed Lisp
packages have aready been recompiled for you.

EOF
}

pkg_postrm() {
	standard-impl-postrm clisp /usr/bin/clisp
}
