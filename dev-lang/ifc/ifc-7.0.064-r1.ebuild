# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ifc/ifc-7.0.064-r1.ebuild,v 1.6 2004/02/09 08:26:16 jhhudso Exp $

inherit rpm

S=${WORKDIR}
DESCRIPTION="Intel Fortran Compiler - The Pentium optimized compiler for Linux"

SRC_URI1="http://developer.intel.com/software/products/compilers/downloads/l_fc_p_7.0.064.tar"
SRC_URI2="ftp://download.intel.com/software/products/compilers/downloads/l_fc_p_7.0.064.tar"
SRC_URI3="ftp://download.intel.co.jp/software/products/compilers/downloads/l_fc_p_7.0.064.tar"
SRC_URI="${SRC_URI1} ${SRC_URI2} ${SRC_URI3}"

HOMEPAGE="http://developer.intel.com/software/products/compilers/flin/"

# Effectively the same license as icc
LICENSE="icc-7.0"
SLOT="0"
KEYWORDS="-* x86"

DEPEND=">=virtual/linux-sources-2.4
	>=sys-libs/glibc-2.2.4"

RDEPEND=">=virtual/linux-sources-2.4
	>=sys-libs/glibc-2.2.4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Keep disk space to a minimum
	rm -f intel-*.ia64.rpm

	for x in intel-*.i386.rpm
	do
		rpm_unpack $x
	done
}

src_compile() {

	# From UNTAG_CFG_FILES in 'install'
	SD=${S}/opt/intel # Build DESTINATION
	RD=/opt/intel # Real DESTINATION
	for FILE in $(find $SD/compiler70/ia??/bin/ -regex '.*[ei][cf]p?c$\|.*cfg$\|.*pcl$\|.*vars[^/]*.c?sh$' 2>/dev/null)
	do
		sed s@\<INSTALLDIR\>@$RD@g ${FILE} > ${FILE}.abs
		mv -f ${FILE}.abs ${FILE}
		chmod 755 ${FILE}
	done

	# From UNTAG_SUPPORT in 'install'
	eval `grep "^[ ]*COMBOPACKAGEID=" install`

	SUPPORTFILE=${SD}/compiler70/docs/fsupport
	sed s@\<INSTALLTIMECOMBOPACKAGEID\>@$COMBOPACKAGEID@g $SUPPORTFILE > $SUPPORTFILE.abs
	mv $SUPPORTFILE.abs $SUPPORTFILE
	chmod 644 $SUPPORTFILE

	SUPPORTFILE=${SD}/compiler70/docs/idbsupport
	sed s@\<INSTALLTIMECOMBOPACKAGEID\>@$COMBOPACKAGEID@g $SUPPORTFILE > $SUPPORTFILE.abs
	mv $SUPPORTFILE.abs $SUPPORTFILE
	chmod 644 $SUPPORTFILE

	# these should not be executable
	find "${SD}/compiler70/"{docs,man,training,ia32/include} -type f -exec chmod -x "{}" ";"
	find "${SD}/compiler70/ia32/lib" -name \*.a -exec chmod -x "{}" ";"
}

src_install () {
	dodoc flicense
	cp -a opt ${D}

	# ifc enviroment
	insinto /etc/env.d
	doins ${FILESDIR}/${PVR}/05icc-ifc
	# fix the issue with the primary ifc executable
	exeinto /opt/intel/compiler70/ia32/bin
	doexe ${FILESDIR}/${PVR}/ifc
}

pkg_postinst () {
	einfo
	einfo "http://www.intel.com/software/products/compilers/flin/noncom.htm"
	einfo "From the above url you can get a free, non-time limited, non-commercial"
	einfo "personal use license key that comes with no support. You will need to read"
	einfo "and agree to the license and then fill in your info to have one emailed to"
	einfo "you. Read the website for the details."
	einfo
	einfo "Documentation can be found in /opt/intel/compiler70/docs/"
	einfo
	einfo "You will need to place your license in /opt/intel/licenses/"
	einfo
		ewarn
		ewarn "Packages compiled with older versions of icc will need"
		ewarn "to be recompiled. Until you do that, old packages will"
		ewarn "work if you edit /etc/ld.so.conf and change 'compiler70'"
		ewarn "to 'compiler60' and run 'ldconfig.' Note that this edit"
		ewarn "won't persist and will require you to re-edit after each"
		ewarn "package you re-install."
	ewarn "Due to a bug in ifc 7.0, the primary executable (ifc) may not work."
	ewarn "Instead of invoking the compiler as ifc, use ifcbin."
}
