# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/mupad/mupad-2.5.2.ebuild,v 1.1 2003/05/12 01:14:29 george Exp $

VER=`echo $PV|awk -F. '{ print $1$2$3 }'`
URLPATH="http://www.ibiblio.org/pub/Linux/apps/math/MuPAD/distrib/unix"
INSTDIR="/usr/lib/mupad"
INSTBINDIR="${INSTDIR}/share/bin"
BINDIR="/usr/bin"

RESTRICT="nostrip"
DESCRIPTION="MuPAD is an open computer algebra system"
HOMEPAGE="http://www.mupad.de/index_uni.shtml"
SRC_URI="${URLPATH}/bin_linux_scilab_${VER}.tgz ${URLPATH}/linux_libs.tgz ${URLPATH}/share_${VER}.tgz"

# If version is 2.5.2, download documentation patch
if [ "${VER}" = "252" ] ; then
	SRC_URI="${SRC_URI} ${URLPATH}/docpatch25x.tgz"
fi

#see also http://www.sciface.com/personal.shtml
LICENSE="mupad"

SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/glibc"
RDEPEND="=dev-lang/tk-8.3*"


src_unpack() {
	echo -n ""
}

src_compile() {
	echo -n ""
}

src_install() {
	einfo "Unpacking binary distribution ..."
	einfo "  - Creating container directory ..."
	dodir ${INSTDIR}
	einfo "  - Unpacking common files ..."
	tar -C ${D}${INSTDIR} -xzpf ${DISTDIR}/share_${VER}.tgz \
		> /dev/null 2>&1 || die
	einfo "  - Unpacking Linux binaries for MuPAD and Scilab ..."
	tar -C ${D}${INSTDIR} -xzpf ${DISTDIR}/bin_linux_scilab_${VER}.tgz \
		> /dev/null 2>&1 || die
	einfo "  - Unpacking support libs for Linux binaries ..."
	tar -C ${D}${INSTDIR} -xzpf ${DISTDIR}/linux_libs.tgz \
		> /dev/null 2>&1 || die
	# This (conditional) patch has to be last, obviously
	if [ "${VER}" = "252" ] ; then
		einfo "Unpacking documentation patch for version 2.5.2 ..."
		tar -C ${D}${INSTDIR} -xzpf ${DISTDIR}/docpatch25x.tgz \
			> /dev/null 2>&1 || die
	fi
	einfo "Making wrapper scripts for executables ..."
	dodir ${BINDIR}
	FILES="mupad xmupad"
	for FILE in $FILES; do
		einfo "  - ${FILE}"
		# How do I get this do "die" if it fails?
		cat > ${D}${BINDIR}/${FILE} <<-ENDOFSCRIPT
			#!/bin/sh
			exec ${INSTBINDIR}/${FILE}
		ENDOFSCRIPT
		fperms 0755 ${BINDIR}/${FILE} || die
	done

	#move docs to the roper place
	dodir /usr/share/doc/${PF}/
	mv ${D}/usr/lib/mupad/share/{changes/*,copyright/*,doc/*} ${D}/usr/share/doc/${PF}/
	rmdir ${D}/usr/lib/mupad/share/{changes,copyright,doc}
	mv ${D}/usr/lib/mupad/{INSTALL,LICENSE} ${D}/usr/share/doc/${PF}/
}

pkg_postinst() {
	echo ""
	einfo "SOME IMPORTANT NOTES:"
	einfo ""
	einfo " - This version of MuPAD has Scilab functionality"
	einfo "   integrated, so if you have Scilab installed already, "
	einfo "   you might find it to be redundant."
	einfo ""
	einfo " - MuPAD is only free for non-commercial use.  Visit"
	einfo "   http://www.mupad.com/ for commercial downloads."
	einfo ""
	einfo " - In this non-commercial version, you must register to"
	einfo "   obtain a license key in order to deactivate the memory"
	einfo "   limit.  The memory limit prevents large calculations."
	einfo "   Read the documentation or visit"
	einfo ""
	einfo "       ${HOMEPAGE}"
	einfo ""
	einfo "   for more info."
	echo ""
}
