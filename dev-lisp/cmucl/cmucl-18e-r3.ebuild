# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cmucl/cmucl-18e-r3.ebuild,v 1.1 2004/02/14 00:07:00 mkennedy Exp $

inherit common-lisp-common

DEB_PV=8

DESCRIPTION="CMUCL Lisp. This conforms to the ANSI Common Lisp Standard"
HOMEPAGE="http://www.cons.org/cmucl/
	http://packages.debian.org/unstable/devel/cmucl.html"
LICENSE="public-domain"
DEPEND="dev-lisp/common-lisp-controller
	doc? ( app-text/tetex )
	X? ( lesstif? ( x11-libs/lesstif ) !lesstif? ( x11-libs/openmotif ) )"
IUSE="doc"
SLOT="0"
KEYWORDS="~x86"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cmucl/cmucl_${PV}-${DEB_PV}.tar.gz
	http://cmucl.cons.org/ftp-area/cmucl/release/18e/cmucl-${PV}-x86-linux.tar.bz2"

PROVIDE="virtual/commonlisp"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}/herald-save.lisp-gentoo.patch
	epatch ${FILESDIR}/${PV}/install-clc.lisp-gentoo.patch
}

src_compile() {
	# non-x86 maintainers, add to the the following and verify

	if use lesstif; then
		sed -i 's,CFLAGS = ,CFLAGS = -I/usr/X11R6/include/lesstif/ ,g' src/motif/server/Config.x86
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
	doins own-work/install-clc.lisp
	exeinto /usr/lib/common-lisp/bin
	cp own-work/cmucl-script.sh cmucl.sh
	doexe cmucl.sh

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

	if use X; then
		exeinto /usr/lib/cmucl
		doexe target/motif/server/motifd
		insinto /usr/lib/cmucl/subsystems/
		doins target/interface/clm-library.x86f
	fi

	keepdir /usr/lib/common-lisp/cmucl

	# BIG FAT HACK
	#
	# Since the Portage emerge step kills file timestamp information,
	# we need to compensate by ensuring all .x86f files are more
	# recent than their .lisp source.

	dodir /usr/share/${PN}
	tar cpvzf ${D}/usr/share/${PN}/portage-timestamp-compensate -C ${D}/usr/lib/${PN} .
}

pkg_postinst() {
	chown cl-builder:cl-builder /usr/lib/common-lisp/cmucl
	tar xvpzf /usr/share/${PN}/portage-timestamp-compensate -C /usr/lib/${PN}
	rm -rf /usr/lib/common-lisp/${PN}/*
	/usr/bin/clc-autobuild-impl ${PN} yes
	register-common-lisp-implementation ${PN}

}

pkg_prerm() {
	# Since we keep our own time stamps we must manually remove them
	# here.
	if [ ! -x /usr/bin/lisp ]; then
		rm -rf /usr/lib/${PN}
	fi
	rm -rf /usr/lib/common-lisp/${PN}/*
}
