# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cmucl-bin/cmucl-bin-18e.ebuild,v 1.2 2003/06/07 20:13:58 mkennedy Exp $

DESCRIPTION="CMUCL Lisp. This conforms to the ANSI Common Lisp Standard"
HOMEPAGE="http://www.cons.org/cmucl/"
LICENSE="public-domain"
DEPEND="dev-lisp/common-lisp-controller"
IUSE=""
SLOT="0"
KEYWORDS="~x86"
SRC_URI="ftp://ftp.cn.freebsd.org/pub/cmucl/release/${PV}/cmucl-${PV}-x86-linux.tar.bz2
	ftp://ftp.cn.freebsd.org/pub/cmucl/release/${PV}/cmucl-${PV}-x86-linux.extra.tar.bz2
	ftp://ftp.cn.freebsd.org/pub/cmucl/release/${PV}/cmucl-${PV}.source.tar.bz2
	ftp://ftp.cn.freebsd.org/pub/cmucl/release/${PV}/cmucl-${PV}.documents.tar.bz2"

PROVIDE="virtual/commonlisp"

S=${WORKDIR}/${P}

src_unpack() {
	mkdir ${P}
	cd ${P}
	unpack cmucl-${PV}-x86-linux.tar.bz2
	unpack cmucl-${PV}-x86-linux.extra.tar.bz2
	unpack cmucl-${PV}.documents.tar.bz2
	unpack cmucl-${PV}.source.tar.bz2
}

src_install() {
	dobin bin/*
	cp -a lib ${D}/usr

# 	dodir /usr/share/common-lisp/
# 	cp -a src ${D}/usr/share/common-lisp/source

	insinto /etc/common-lisp/cmucl
	doins ${FILESDIR}/site-init.lisp
	dosym /etc/common-lisp/cmucl/site-init.lisp /usr/lib/cmucl/lib/site-init.lisp

	doman man/man1/*.1
	dodoc doc/cmucl/README doc/cmucl/release-*.txt
	dodoc `find ${S}/package/doc/cmucl/ -type f \( -name \*.ps -o -name \*.pdf \) -print`
	dodoc ${FILESDIR}/${PV}/README.Gentoo

	[ -f /etc/lisp-config.lisp ] || touch ${D}/etc/lisp-config.lisp

 	dodir /etc/env.d
 	cat >${D}/etc/env.d/50cmucl <<EOF
CMUCLLIB=/usr/lib/cmucl
EOF
	mv ${D}/usr/lib/cmucl/lib/lisp.core ${D}/usr/lib/cmucl/lib/lisp-dist.core
	dosym /usr/lib/cmucl/lib/lisp-dist.core /usr/lib/cmucl/lisp-dist.core

	insinto /usr/lib/cmucl
	doins ${FILESDIR}/install-clc.lisp

	exeinto /usr/lib/common-lisp/bin
	cp ${FILESDIR}/cmucl-script.sh cmucl.sh
	doexe cmucl.sh
}

pkg_postinst() {
	einfo ">>> Fixing permissions for executables and directories..."
	find /usr/share/common-lisp/source -type d -o \( -type f -perm +111 \) \
		|xargs chmod 755
	einfo ">>> fix permissions for non-executable files..."
	find /usr/share/common-lisp/source -type f ! -perm -111 \
		|xargs chmod 644

	/usr/sbin/register-common-lisp-implementation cmucl
}

pkg_postrm() {
	/usr/sbin/unregister-common-lisp-implementation cmucl
}
