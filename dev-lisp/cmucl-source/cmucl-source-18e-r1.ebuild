# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cmucl-source/cmucl-source-18e-r1.ebuild,v 1.2 2004/03/24 05:18:43 mkennedy Exp $

inherit common-lisp

DEB_PV=8

DESCRIPTION="These are the CMUCL sources, provided so that the debugger can show useful source information at appropriate times.  This version includes common-lisp-controller compatible replacements for defsystem, graystream, clx and hemlock."
HOMEPAGE="http://packages.debian.org/unstable/devel/cmucl-source.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cmucl/cmucl_${PV}-${DEB_PV}.tar.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	dev-lisp/cl-asdf
	virtual/commonlisp"

S=${WORKDIR}/cmucl-${PV}

CLPACKAGE="cmucl-clx cmucl-graystream cmucl-hemlock"

src_unpack() {
	unpack ${A}
	find ${S} -type d -name CVS -print0 |xargs -0 rm -rf
}

src_install() {
	# non-asd/system code
	dodir /usr/share/common-lisp/source/cmucl
	(cd src ; find . -name \*.lisp -and -type f | tar --create --file=- --files-from=- ) |\
		tar --extract --file=- -C ${D}/usr/share/common-lisp/source/cmucl
	dodir /usr/share/common-lisp/systems
	# gray-stream
	insinto /usr/share/common-lisp/source/cmucl-graystream
	doins src/pcl/gray-streams* ${FILESDIR}/${PV}/cmucl-graystream.asd
	dosym /usr/share/common-lisp/source/cmucl-graystream/cmucl-graystream.asd \
		/usr/share/common-lisp/systems/
	# CLX
	insinto /usr/share/common-lisp/source/cmucl-clx
	cp -r src/clx/*.lisp ${FILESDIR}/${PV}/cmucl-clx.asd \
		src/code/clx-ext.lisp \
		src/hemlock/charmacs.lisp \
		src/hemlock/key-event.lisp \
		src/hemlock/keysym-defs.lisp \
		${D}/usr/share/common-lisp/source/cmucl-clx
	insinto /usr/share/common-lisp/source/cmucl-clx/debug
	doins src/clx/debug/*.lisp
	insinto /usr/share/common-lisp/source/cmucl-clx/demo
	doins src/clx/demo/*.lisp
	insinto /usr/share/common-lisp/source/cmucl-clx/test
	doins src/clx/test/*.lisp
	find ${D}/usr/share/common-lisp/source/cmucl-clx -type f -print0 | xargs -0 chmod 644
	find ${D}/usr/share/common-lisp/source/cmucl-clx -type d -print0 | xargs -0 chmod 755
	dosym /usr/share/common-lisp/source/cmucl-clx/cmucl-clx.asd \
		/usr/share/common-lisp/systems/
	# hemlock
	insinto /usr/share/common-lisp/source/cmucl-hemlock
	doins src/hemlock/*.lisp \
		src/hemlock/XKeysymDB \
		src/hemlock/compilation.order \
		src/hemlock/hemlock.log \
		src/hemlock/hemlock.upd \
		src/hemlock/hemlock11.cursor \
		src/hemlock/hemlock11.mask \
		src/hemlock/mh-scan \
		src/hemlock/notes.txt \
		src/hemlock/perq-hemlock.log \
		src/hemlock/spell-dictionary.text \
		src/hemlock/things-to-do.txt \
		${FILESDIR}/${PV}/cmucl-hemlock*.asd
	dosym /usr/share/common-lisp/source/cmucl-hemlock/cmucl-hemlock.asd \
		/usr/share/common-lisp/systems/
	dosym /usr/share/common-lisp/source/cmucl-hemlock/cmucl-hemlock-base.asd \
		/usr/share/common-lisp/systems/
	dosym /usr/share/common-lisp/source/cmucl-hemlock/cmucl-hemlock-dict.asd \
		/usr/share/common-lisp/systems/
	# documentation
	insinto /usr/share/doc/${PF}/clx
	gzip own-work/clx/*.ps
	doins own-work/clx/*.{ps.gz,el} own-work/clx/README* # own-work/clx/Makefile
	insinto /usr/share/doc/${PF}/clx/clxman
	doins own-work/clx/clxman/*
	chown -R root:root ${D}/usr/share/common-lisp/source/
}

pkg_postinst() {
	/usr/sbin/register-common-lisp-source cmucl-graystream
	/usr/sbin/register-common-lisp-source cmucl-clx
	/usr/sbin/register-common-lisp-source cmucl-hemlock
}

pkg_prerm() {
	/usr/sbin/unregister-common-lisp-source cmucl-graystream
	/usr/sbin/unregister-common-lisp-source cmucl-clx
	/usr/sbin/register-common-lisp-source cmucl-hemlock
}
