# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ladebug/ladebug-4.0.67.ebuild,v 1.1 2003/04/15 03:15:38 taviso Exp $
#
# Submitted By Tavis Ormandy <taviso@gentoo.org>
#

IUSE="emacs"

inherit elisp

DESCRIPTION="Linux port of the Famous Tru64 Debugger"
HOMEPAGE="http://www.support.compaq.com/alpha-tools"
#HOMEPAGE="ftp://ftp.compaq.com/pub/products/linuxdevtools/latest/downloads.html"
#SRC_URI="ftp://ftp.compaq.com/pub/products/linuxdevtools/latest/ladebug-4.0.67-21.alpha.rpm"
LICENSE="PLDSPv2"
SLOT="0"
# NOTE: ALPHA Only!
KEYWORDS="-* ~alpha"
DEPEND="virtual/glibc
		app-arch/rpm2targz
		dev-libs/libots
		dev-libs/libcpml
		emacs? ( virtual/emacs )"
S=${WORKDIR}/${P}
RELEASE="4.0.67-21"
SITEFILE="50ladebug.el"

src_unpack() {
	# convert rpm into tar archive
	local ladebug_rpm="ladebug-${RELEASE}.alpha.rpm"
	if [ ! -f ${DISTDIR}/${ladebug_rpm} ]; then
		eerror ""
		eerror "Please download ${ladebug_rpm} from" 
		eerror "${HOMEPAGE}, and place it in"
		eerror "${DISTDIR}"
		eerror ""
		eerror "Then resart this emerge."
		eerror ""
		die "Ladebug Distribution (${ladebug_rpm}) not found"
	else
		ebegin "Unpacking Ladebug Distribution..."
		i=${DISTDIR}/${ladebug_rpm}
		dd ibs=`rpmoffset < ${i}` skip=1 if=$i 2>/dev/null \
			| gzip -dc | cpio -idmu 2>/dev/null \
			&& find usr -type d -print0 | xargs -0 chmod a+rx
		eend ${?}
		assert "Failed to extract ${ladebug_rpm%.rpm}.tar.gz"
		
		eend ${?}
	fi
}

src_compile() {
	# remove emacs lisp files
	if ! use emacs >/dev/null ; then
		einfo "Removing emacs Ladebug integration (USE=\"-emacs\"?)..."
		rm -rf ${WORKDIR}/usr/lib/emacs ${WORKDIR}/usr/lib/compaq/ladebug-V67/ladebug.el
	else
		einfo "Preparing emacs Ladebug integration (USE=\"emacs\"?)..."
		rm -rf ${WORKDIR}/usr/lib/emacs
	fi
	
	# man pages are in the wrong place
	einfo "Reorganising man structure..."
	rm -rf ${WORKDIR}/usr/man
	mkdir -p ${WORKDIR}/usr/share/man/man1
	mv ${WORKDIR}/usr/lib/compaq/ladebug-V67/ladebug.1.gz ${WORKDIR}/usr/share/man/man1
	
	einfo "Reorganising Documentation structure..."
	mv ${WORKDIR}/usr/doc ${WORKDIR}/usr/share/
	cp -r ${WORKDIR}/usr/share/locale/en_US ${WORKDIR}/usr/share/locale/C
}

src_install() {
	# move files over
	mv ${WORKDIR}/usr ${D} || die "Ladebug Installation Failed"
	
	# prep manpages
	prepman ${D}/usr/share/man/man1/ladebug.1.gz
	prepalldocs
	if use emacs >/dev/null ; then
		elisp-install ${PN} ladebug.el
		#FIXME: how does this work?
		#elisp-site-file-install ${FILESDIR}/${SITEFILE}
		cp ${FILESDIR}/${SITEFILE} ${D}/usr/share/emacs/site-lisp/
	fi
}

pkg_postinst () {
			einfo
			einfo "Ladebug ${RELEASE} has been merged successfully"
			einfo
			use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
