# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/staden/staden-1.4.1-r2.ebuild,v 1.1 2004/09/16 04:12:35 ribosome Exp $

inherit eutils

DESCRIPTION="The Staden Package - Biological sequence handling and analysis"
HOMEPAGE="http://${PN}.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-rel-${PV//./-}.tar.gz
	mirror://gentoo/${P}-doc.tar.bz2
	doc? mirror://gentoo/${P}-course.tar.bz2"
LICENSE="${PN}"

SLOT="0"
KEYWORDS="~x86"
IUSE="doc emboss ifc"

DEPEND="${RDEPEND}
	dev-lang/perl
	emboss? ( app-sci/emboss )
	ifc? ( dev-lang/ifc )"

RDEPEND="app-shells/ksh
	dev-lang/tcl
	dev-lang/tk
	=dev-tcltk/itcl-3.2*
	dev-tcltk/iwidgets
	media-libs/libpng
	virtual/x11"

S=${WORKDIR}/${PN}-src-rel-${PV//./-}

pkg_setup() {
	# Check for a Fortran compiler.
	if ! which ${F77:-g77} &> /dev/null; then
		echo
		eerror "The Fortran compiler \"${F77:-g77}\" could not be found on your system."
		if [ -z ${F77} ] || [ ${F77} = g77 ]; then
			eerror 'Please reinstall "sys-devel/gcc" with the "f77" "USE" flag enabled.'
		elif [ ${F77} = ifc ] && ! use ifc &> /dev/null; then
			eerror 'Please set the "ifc" "USE" flag if you want to use the Intel Fortran'
			eerror 'Compiler to build this package. This will ensure the "dev-lang/ifc"'
			eerror 'package gets installed on your system.'
		elif [ ${F77} = ifc ] && use ifc &> /dev/null; then
			eerror 'Please ensure "ifc" is in a directory referenced in "PATH".'
		else
			eerror 'Please make sure the variable ${F77} is set to the name of a valid'
			eerror 'Fortran compiler installed on your system. Make sure this executable'
			eerror 'is in a directory referenced by "PATH", and that the corresponding'
			eerror '"USE" flag is set if applicable (for example "ifc" if you use the'
			eerror 'Intel Fortran Compiler).'
		fi
		die "Fortran compiler not found."
	fi

	# Check for X authority if building the EMBOSS tcl/tk GUIs.
	if use "emboss" && [ -z ${XAUTHORITY} ]; then
		echo
		eerror 'The "XAUTHORITY" environment variable is not set on your system.'
		eerror 'Access to an X display is required to build the EMBOSS tcl/tk GUIs.'
		eerror 'Please either unset the "emboss" "USE" flag to install this package'
		eerror 'without building the EMBOSS GUIs (you will still be provided with a'
		eerror 'set of prebuilt GUIs) or configure access to an X display. You can'
		eerror 'transfer the X credentials of an ordinary user to the account you'
		eerror 'use to execute "emerge" with the "sux" command, which is part of the'
		eerror '"x11-misc/sux" package. See: "http://www.gentoo.org/doc/en/su-x.xml"'
		eerror 'for an introduction to installing and using "sux" on Gentoo.'
		die '"XAUTHORITY" not set.'
	fi
}

src_unpack() {
	unpack ${A}

	# The following Makefiles are more or less broken. Libraries are missing,
	# or their directories are not included, or the variables are not set
	# correctly and must be replaced by hardcoded library names. The
	# top-level Makefile is also changed to avoid compiling documentation
	# (which is provided prebuilt because of numerous compilation/dead links
	# problems).

	cd ${S}
	einfo "Patching Staden Package Makefiles:"
	epatch ${FILESDIR}/${P}-top.patch
	epatch ${FILESDIR}/${P}-gap4.patch
	epatch ${FILESDIR}/${P}-mutscan.patch
	epatch ${FILESDIR}/${P}-prefinish.patch
	epatch ${FILESDIR}/${P}-tk_utils.patch
	epatch ${FILESDIR}/${P}-tracediff.patch
	echo

	# "getopt" is incorrectly included as an extern (for Win32 compatibility).
	einfo "Patching Staden Package code:"
	epatch ${FILESDIR}/${P}-getopt.patch
	echo

	# "CFLAGS" and "FFLAGS" need to be set to the user's values in the build
	# system global Makefile.
	einfo "Applying user-defined compilation/linking flags:"
	cd ${S}/src/mk
	sed -i -e "s/COPT		= -O2 -g3 -DNDEBUG/COPT = ${CFLAGS:-"-O2 -g3 -DNDEBUG"}/" global.mk \
		&& einfo "Successfully applied sed script to set CFLAGS." \
		|| eerror "Failed to apply sed script to set CFLAGS."
	sed -i -e "s/FOPT		= -O2 -g3 -DNDEBUG/FOPT = ${FFLAGS:-"-O2 -g3 -DNDEBUG"}/" global.mk \
		&& einfo "Successfully applied sed script to set FFLAGS." \
		|| eerror "Failed to apply sed script to set FFLAGS."
}

src_compile() {
	# "MACHINE", "{STADEN,SRC}ROOT" and "JOB" are mandatory arguments to the
	# Staden Package build process. "O" is redefined on the command line to
	# avoid a conflict between Portage and the Staden Package build system,
	# which both use this variable. (In Portage, its value is the directory
	# containing the current ebuild, while in the Staden Package build system
	# it is set to the directory containing the compiler object files.)
	# Compiler program names also need to be specified to override the
	# incorrect hardcoded ones.

	# Compiles executables and libraries.
	make \
		STADENROOT="${S}" \
		SRCROOT="${S}/src" \
		MACHINE="linux" \
		JOB="all" \
		O="linux-binaries" \
		CC=${CC:-gcc} \
		CXX=${CXX:-g++} \
		F77=${F77:-g77} \
		|| die "Package compilation failed."

	# Moves executables in "${S}/linux-bin" and libraries to ${S}/lib.
	make \
		STADENROOT="${S}" \
		SRCROOT="${S}/src" \
		MACHINE="linux" \
		JOB="all" \
		O="linux-binaries" \
		install || die "Package pre-installation failed."

	# Remove Makefiles from directories which will be manually installed.
	rm ${S}/lib/Makefile
	rm ${S}/demo/Makefile
	rm ${S}/tables/Makefile
	rm ${S}/userdata/Makefile

	# Remove trashed "linux-binaries" file and replace it by a directory
	# containing the appropriate libraries.
	rm ${S}/lib/linux-binaries
	mkdir ${S}/lib/linux-binaries
	mv ${S}/src/lib/linux-binaries/* ${S}/lib/linux-binaries

	# Link "itcl" and "itk" libraries to the Staden libraries directories.
	ln -s /usr/lib/libitcl3.2.so ${S}/lib/itcl3.3/libitcl3.3.so
	ln -s /usr/lib/libitk3.2.so ${S}/lib/itk3.3/libitk3.3.so

	# Patched version of iwidgetsrc
	cp ${FILESDIR}/${P}-iwidgetsrc.new ${S}/tables/iwidgetsrc

	# Build tcl/tk GUIs for EMBOSS programs if requested.
	use "emboss" && STADENROOT="${S}" ${S}/linux-bin/create_emboss_files

	# Netscape is not a good default browser (security masked in Portage).
	# Use documentation.html rather than staden_home.html as the top-level
	# hypertext documentation file.
	cp ${FILESDIR}/${P}-staden_help.new ${S}/linux-bin/staden_help
	chmod +x ${S}/linux-bin/staden_help

}

src_install() {
	# Executables and libraries
	into /opt/${PN}
	mkdir -p ${D}/opt/${PN}
	mv ${S}/linux-bin ${D}/opt/${PN}/linux-bin
	mv ${S}/lib ${D}/opt/${PN}/lib

	# Shared files
	mv ${S}/demo ${D}/opt/${PN}
	mv ${S}/tables ${D}/opt/${PN}
	mv ${S}/userdata ${D}/opt/${PN}

	# "env" file for setting paths to Staden Package root, libraries, tables...
	insinto /etc/env.d
	newins ${FILESDIR}/${P}-env 27${PN}

	# Man pages
	doman ${S}/doc/manual/man/man*/*

	# Documentation
	mv ${WORKDIR}/doc ${D}/opt/${PN}/doc

	# A short course in printable format along with some data
	use doc && mv ${WORKDIR}/course ${D}/opt/${PN}/course

}

pkg_postinst() {
	echo
	ewarn 'Known issues:'
	ewarn
	ewarn 'The help browser integrated in the GUI applications reports missing'
	ewarn 'files when following hyperlinks on the main documentation page. This'
	ewarn 'seems to be a problem in the Staden Package help browser. You might'
	ewarn 'want to use your favorite browser instead of the integrated one to'
	ewarn 'read the documentation.'
	ewarn
	ewarn 'The GUI programs may crash when bringing up the font selection'
	ewarn 'dialog. This problem is related to the presence of certain'
	ewarn 'fonts in "FontPath". If you experience this problem, try using'
	ewarn '"strace" to identify the problematic font(s) and either uninstall'
	ewarn 'them or remove the directory they are in from "FontPath" by'
	ewarn 'editing your X server configuration file.'
	ewarn
	ewarn 'The default EMBOSS tcl/tk GUIs (which get installed if you did not'
	ewarn 'set the "emboss" "USE" flag) are way out of date, while the custom'
	ewarn 'GUIs (which are built if you set the "emboss" "USE" flag) do not'
	ewarn 'support many of the most recent EMBOSS/EMBASSY programs.'
	echo
}
