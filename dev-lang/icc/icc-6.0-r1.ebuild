# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/icc/icc-6.0-r1.ebuild,v 1.9 2003/05/10 22:51:35 avenj Exp $

S=${WORKDIR}

DESCRIPTION="Intel C++ Compiler - The Pentium optimized compiler for Linux"

#RESTRICT="fetch"

SRC_URI1="http://developer.intel.com/software/products/compilers/downloads/l_cc_p_6.0.139.tar"
SRC_URI2="ftp://download.intel.com/software/products/compilers/downloads/l_cc_p_6.0.139.tar"
SRC_URI3="ftp://download.intel.co.jp/software/products/compilers/downloads/l_cc_p_6.0.139.tar"
SRC_URI="${SRC_URI1} ${SRC_URI2} ${SRC_URI3}"

HOMEPAGE="http://www.intel.com/software/products/compilers/clin/"

LICENSE="icc-6.0"

DEPEND="virtual/linux-sources
		>=sys-libs/glibc-2.2.2
		sys-apps/cpio
		app-arch/rpm"

RDEPEND="virtual/linux-sources
		>=sys-libs/glibc-2.2.2"

SLOT="0"
KEYWORDS="-* x86"

src_compile() {
	# Keep disk space to a minimum
	rm -f intel-*.ia64.rpm

	mkdir opt

	for x in intel-*.i386.rpm
	do
		einfo "Extracting: ${x}"
		rpm2cpio ${x} | cpio --extract --make-directories --unconditional
	done

	# From UNTAG_CFG_FILES in 'install'
	SD=${S}/opt/intel # Build DESTINATION
	RD=/opt/intel # Real DESTINATION
	for FILE in $(find $SD/compiler60/ia??/bin/ -regex '.*[ei][cf]p?c$\|.*cfg$\|.*pcl$\|.*vars[^/]*.c?sh$' 2>/dev/null)
	do
		sed s@\<INSTALLDIR\>@$RD@g ${FILE} > ${FILE}.abs
		mv -f ${FILE}.abs ${FILE}
		chmod 755 ${FILE}
	done

	# From UNTAG_SUPPORT in 'install'
	eval `grep "^[ ]*COMBOPACKAGEID=" install`

	SUPPORTFILE=${SD}/compiler60/docs/csupport
	sed s@\<INSTALLTIMECOMBOPACKAGEID\>@$COMBOPACKAGEID@g $SUPPORTFILE > $SUPPORTFILE.abs
	mv $SUPPORTFILE.abs $SUPPORTFILE
	chmod 644 $SUPPORTFILE

	SUPPORTFILE=${SD}/compiler60/docs/ldbsupport
	sed s@\<INSTALLTIMECOMBOPACKAGEID\>@$COMBOPACKAGEID@g $SUPPORTFILE > $SUPPORTFILE.abs
	mv $SUPPORTFILE.abs $SUPPORTFILE
	chmod 644 $SUPPORTFILE
}

src_install () {
	dodoc lgpltext
	dodoc clicense
	cp -a opt ${D}

	# icc enviroment
	insinto /etc/env.d
	doins ${FILESDIR}/${PVR}/05icc-ifc
}

pkg_postinst () {
	einfo
	einfo "http://www.intel.com/software/products/compilers/c60l/c60l_noncom_lic.htm"
	einfo "From the above url you can get a free, non-time limited, non-commercial"
	einfo "personal use license key that comes with no support. You will need to read"
	einfo "and agree to the license and then fill in your info to have one emailed to"
	einfo "you. Read the website for the details."
	einfo
	einfo "Documentation can be found in /opt/intel/compiler60/docs/ ."
	einfo
	einfo "You will need to place your license in /opt/intel/licenses/ ."
	einfo
	if [ -d /opt/intel/compiler50 ]
	then
		ewarn
		ewarn "Packages compiled with icc-5 will need to be recompiled."
		ewarn "Until you can do that the old packages will work if you edit /etc/ld.so.conf and"
		ewarn "change the 'compiler60' to 'compiler50' and run 'ldconfig'. Note that this edit"
		ewarn "won't persist and will require you to re-edit after each package you re-install."
		ewarn
		ewarn "I know it sucks, and I've complained to Intel with all the details."
		ewarn
	fi
}
