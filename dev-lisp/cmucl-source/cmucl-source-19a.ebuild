# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cmucl-source/cmucl-source-19a.ebuild,v 1.3 2005/02/10 09:18:30 mkennedy Exp $

inherit common-lisp eutils

DEB_PV=2
MY_PV=${PV}-release-20040728

# DESCRIPTION="Source code for CMUCL, with CLX, Gray Streams and Hemlock for CMUCL"
DESCRIPTION="Source code for CMUCL with a Gray Streams system definition for CMUCL"
HOMEPAGE="http://packages.debian.org/unstable/devel/cmucl-source.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cmucl/cmucl_${MY_PV}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/c/cmucl/cmucl_${MY_PV}-${DEB_PV}.diff.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	dev-lisp/cl-asdf
	virtual/commonlisp"

S=${WORKDIR}/cmucl-${MY_PV}.orig

# CLPACKAGE="cmucl-clx cmucl-graystream cmucl-hemlock"
CLPACKAGE=" cmucl-graystream"

ASDF_DIR=${S}/own-work

src_unpack() {
	unpack ${A}
	epatch cmucl_${MY_PV}-${DEB_PV}.diff
	epatch ${FILESDIR}/${PV}/cmucl-hemlock-dict.asd-gentoo.patch
}

src_install() {
	dodir /usr/share/common-lisp/source/cmucl
	(cd src ; find . -name \*.lisp -and -type f | tar --create --file=- --files-from=- ) |\
		tar --extract --file=- -C ${D}/usr/share/common-lisp/source/cmucl
	dodir /usr/share/common-lisp/systems

	# CMUCL-GRAYSTREAM
	insinto /usr/share/common-lisp/source/cmucl-graystream
	doins src/pcl/gray-streams* ${ASDF_DIR}/cmucl-graystream.asd
	dosym /usr/share/common-lisp/source/cmucl-graystream/cmucl-graystream.asd \
		/usr/share/common-lisp/systems/

#	# CMUCL-CLX
#	insinto /usr/share/common-lisp/source/cmucl-clx
#	cp -r src/clx/*.lisp ${ASDF_DIR}/cmucl-clx.asd \
#		src/code/clx-ext.lisp \
#		src/hemlock/charmacs.lisp \
#		src/hemlock/key-event.lisp \
#		src/hemlock/keysym-defs.lisp \
#		${D}/usr/share/common-lisp/source/cmucl-clx
#	insinto /usr/share/common-lisp/source/cmucl-clx/debug
#	doins src/clx/debug/*.lisp
#	insinto /usr/share/common-lisp/source/cmucl-clx/demo
#	doins src/clx/demo/*.lisp
#	insinto /usr/share/common-lisp/source/cmucl-clx/test
#	doins src/clx/test/*.lisp
# #	find ${D}/usr/share/common-lisp/source/cmucl-clx -type f -print0 | xargs -0 chmod 644
# #	find ${D}/usr/share/common-lisp/source/cmucl-clx -type d -print0 | xargs -0 chmod 755
#	dosym /usr/share/common-lisp/source/cmucl-clx/cmucl-clx.asd \
#		/usr/share/common-lisp/systems/

#	# CMUCL-HEMLOCK
#	insinto /usr/share/common-lisp/source/cmucl-hemlock
#	doins src/hemlock/*.lisp \
#		src/hemlock/XKeysymDB \
#		src/hemlock/compilation.order \
#		src/hemlock/hemlock.log \
#		src/hemlock/hemlock.upd \
#		src/hemlock/hemlock11.cursor \
#		src/hemlock/hemlock11.mask \
#		src/hemlock/mh-scan \
#		src/hemlock/notes.txt \
#		src/hemlock/perq-hemlock.log \
#		src/hemlock/spell-dictionary.text \
#		src/hemlock/things-to-do.txt \
#		${ASDF_DIR}/cmucl-hemlock*.asd
#	for asdf in hemlock \
#		hemlock-base \
#		hemlock-dict; do
#	  dosym /usr/share/common-lisp/source/cmucl-hemlock/cmucl-${asdf}.asd \
#		  /usr/share/common-lisp/systems/cmucl-${asdf}.asd
#	done

#	insinto /usr/share/doc/${PF}/clx
#	gzip own-work/clx/*.ps
#	doins own-work/clx/*.{ps.gz,el} own-work/clx/README* # own-work/clx/Makefile
#	insinto /usr/share/doc/${PF}/clx/clxman
#	doins own-work/clx/clxman/*
	chown -R root:root ${D}/usr/share/common-lisp/source/
}

pkg_postinst() {
	/usr/sbin/register-common-lisp-source cmucl-graystream

#	/usr/sbin/register-common-lisp-source cmucl-clx
#	/usr/sbin/register-common-lisp-source cmucl-hemlock
}

pkg_prerm() {
	/usr/sbin/unregister-common-lisp-source cmucl-graystream
#	/usr/sbin/unregister-common-lisp-source cmucl-clx
#	/usr/sbin/unregister-common-lisp-source cmucl-hemlock
}
