# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ifc/ifc-7.1.008.ebuild,v 1.1 2004/02/09 08:26:16 jhhudso Exp $

inherit rpm

DESCRIPTION="Intel Fortran Compiler 7.1 for Linux"
#            Try it on non-Intel x86 processors. It works on my Athlon.
HOMEPAGE="http://www.intel.com/software/products/compilers/flin/"
SRC_URI1="ftp://download.intel.com/software/products/compilers/downloads/l_fc_p_${PV}.tar"
SRC_URI2="http://www.intel.com/software/products/compilers/downloads/l_fc_p_${PV}.tar"
SRC_URI3="ftp://download.intel.co.jp/software/products/compilers/downloads/l_fc_p_${PV}.tar"
SRC_URI="${SRC_URI1} ${SRC_URI2} ${SRC_URI3}"

KEYWORDS="-* ~x86"
SLOT="0"
LICENSE="icc-7.0" # Effectively the same license as icc
IUSE=""

DEPEND=">=virtual/linux-sources-2.4
	>=sys-libs/glibc-2.2.4"

RDEPEND=">=virtual/linux-sources-2.4
	>=sys-libs/glibc-2.2.4"

S=${WORKDIR}

src_unpack() {
	unpack ${A}

	for x in intel-*.i386.rpm;
	do
		rpm_unpack ${x} || die "Failed to unpack rpms.";
	done

	# From UNTAG_CFG_FILES() in Intel's 'install' script:
	SD=${S}/opt/intel # Build DESTINATION
	RD=/opt/intel # Real DESTINATION
	for FILE in $(find $SD/compiler70/ia??/bin/ -regex '.*[ei][cf]p?c$\|.*cfg$\|.*pcl$\|.*vars[^/]*.c?sh$' 2>/dev/null)
	do
		sed s@\<INSTALLDIR\>@$RD@g ${FILE} > ${FILE}.abs
		mv -f ${FILE}.abs ${FILE}
		chmod 755 ${FILE}
	done

# replace tags with package id in special files (from UNTAG_SUPPORT() in Intel's 'install' script)
	eval `grep "^[ ]*COMBOPACKAGEID=" install`

	SUPPORTFILE=${SD}/compiler70/docs/fsupport
	sed s@\<INSTALLTIMECOMBOPACKAGEID\>@$COMBOPACKAGEID@g $SUPPORTFILE > $SUPPORTFILE.abs
	mv $SUPPORTFILE.abs $SUPPORTFILE
	chmod 644 $SUPPORTFILE

	SUPPORTFILE=${SD}/compiler70/docs/idbsupport
	sed s@\<INSTALLTIMECOMBOPACKAGEID\>@$COMBOPACKAGEID@g $SUPPORTFILE > $SUPPORTFILE.abs
	mv $SUPPORTFILE.abs $SUPPORTFILE
	chmod 644 $SUPPORTFILE
}

src_install () {
	mv -f opt ${D}

	insinto /etc/env.d
	doins ${FILESDIR}/${PVR}/05icc-ifc

	# fix the issue with the primary ifc executable
	exeinto /opt/intel/compiler70/ia32/bin
	doexe ${FILESDIR}/${PVR}/ifc
}

pkg_postinst() {
	einfo
	einfo "http://www.intel.com/software/products/compilers/flin/noncom.htm"
	einfo
	einfo "From the above url you can get a free, non-time limited, non-commercial"
	einfo "personal use license key that comes with no support. You will need to read"
	einfo "and agree to the license and then fill in your info to have one emailed to"
	einfo "you. Read the website for details."
	einfo
	einfo "You will need to place your license in /opt/intel/licenses/"
	einfo
	einfo "Note that if you are upgrading from an older version you do not need a new"
	einfo "license."
	einfo
	einfo "Documentation for the compiler can be found in /opt/intel/compiler70/docs/"
	einfo
}
