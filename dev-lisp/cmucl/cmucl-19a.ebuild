# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cmucl/cmucl-19a.ebuild,v 1.4 2004/11/30 21:50:10 swegener Exp $

inherit common-lisp-common eutils

DEB_PV=2
MY_PV=${PV}-release-20040728

DESCRIPTION="CMU Common Lisp is an implementation of ANSI Common Lisp"
HOMEPAGE="http://www.cons.org/cmucl/
	http://packages.debian.org/unstable/devel/cmucl.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cmucl/cmucl_${MY_PV}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/c/cmucl/cmucl_${MY_PV}-${DEB_PV}.diff.gz
	ftp://ftp.common-lisp.net/pub/project/cmucl/release/${PV}/${PN}-${PV}-x86-linux.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc lesstif"

DEPEND="dev-lisp/common-lisp-controller
	>=dev-lisp/cl-defsystem3-3.3i-r3
	>=dev-lisp/cl-asdf-1.84
	doc? ( virtual/tetex )
	lesstif? ( x11-libs/lesstif )
	!lesstif? ( x11-libs/openmotif )"

PROVIDE="virtual/commonlisp"

S=${WORKDIR}/cmucl-${MY_PV}.orig

src_unpack() {
	unpack ${A}
	epatch cmucl_${MY_PV}-${DEB_PV}.diff
	epatch ${FILESDIR}/${PV}/herald-save.lisp-gentoo.patch
}

src_compile() {
	# non-x86 maintainers, add to the the following and verify

	if use lesstif || test -d /usr/X11R6/include/lesstif; then
		sed -i -e 's,-I/usr/X11R6/include,-I/usr/X11R6/include/lesstif,g' \
			-e 's,-L/usr/X11R6/lib,-L/usr/X11R6/lib/lesstif -L/usr/X11R6/lib,g' \
			src/motif/server/Config.x86
	fi

	PATH=${WORKDIR}/bin:$PATH CMUCLCORE=${WORKDIR}/lib/cmucl/lib/lisp.core make || die

	if use doc; then
		make -C src/docs
	fi
}

src_install() {
	insinto /usr/lib/cmucl/include
	doins src/lisp/*.h target/lisp/*.h target/lisp/*.map target/lisp/*.nm
	insinto /usr/lib/cmucl
	cp target/lisp/lisp.core lisp-dist.core
	doins lisp-dist.core

	dodoc target/lisp/lisp.{nm,map}
	doman src/general-info/{cmucl,lisp}.1

	dobin target/lisp/lisp
	dobin own-work/Demos/lisp-start

	insinto /usr/lib/cmucl
	doins ${FILESDIR}/${PV}/install-clc.lisp
	exeinto /usr/lib/common-lisp/bin
	doexe ${FILESDIR}/${PV}/cmucl.sh

	insinto /etc/common-lisp/cmucl
	sed "s,@PF@,${PF},g" <${FILESDIR}/${PV}/site-init.lisp.in >site-init.lisp
	doins site-init.lisp
	dosym /etc/common-lisp/cmucl/site-init.lisp /usr/lib/cmucl/site-init.lisp

	dodir /etc/env.d
	cat >${D}/etc/env.d/50cmucl <<EOF
# CMUCLLIB=/usr/lib/cmucl
EOF
	[ -f /etc/lisp-config.lisp ] || touch ${D}/etc/lisp-config.lisp

	insinto /usr/share/doc/${P}/html/Basic-tutorial
	doins own-work/tutorials/Basic-tutorial/*
	insinto /usr/share/doc/${P}/html/Clos
	doins own-work/tutorials/Clos/*
	docinto notes
	dodoc own-work/tutorials/notes/*

	insinto /usr/lib/cmucl
	doins own-work/hemlock11.*

	if use doc; then
		dodoc src/docs/*/*.{ps,pdf}
	fi

	exeinto /usr/lib/cmucl
	doexe target/motif/server/motifd
	insinto /usr/lib/cmucl/subsystems/
	doins target/interface/clm-library.x86f

	keepdir /usr/lib/common-lisp/cmucl
	impl-save-timestamp-hack cmucl || die
}

pkg_postinst() {
	standard-impl-postinst cmucl
}

pkg_prerm() {
	standard-impl-postrm cmucl /usr/bin/lisp
}
