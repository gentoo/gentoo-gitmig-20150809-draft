# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/staden/staden-1.4.1-r7.ebuild,v 1.1 2004/09/23 02:52:32 ribosome Exp $

inherit eutils

DESCRIPTION="The Staden Package - Biological sequence handling and analysis"
HOMEPAGE="http://${PN}.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-rel-${PV//./-}.tar.gz
	doc? mirror://sourceforge/${PN}/course-1.1.tar.gz
	mirror://gentoo/${P}-missing-doc.tar.bz2"
LICENSE="${PN}"

SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND="${RDEPEND}
	dev-lang/perl
	media-gfx/imagemagick
	virtual/emacs
	virtual/tetex"

RDEPEND="app-shells/ksh
	dev-lang/tcl
	dev-lang/tk
	dev-libs/io_lib
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
		else
			eerror 'Please make sure the variable ${F77} is set to the name of a valid'
			eerror 'Fortran compiler installed on your system. Make sure this executable'
			eerror 'is in a directory included in "PATH", and that the corresponding'
			eerror '"USE" flag is set if applicable (for example "ifc" if you use the'
			eerror 'Intel Fortran Compiler).'
		fi
		die "Fortran compiler not found."
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
	cd ${S}/src/mk
	# Remove the "-fpic" flag. This will be replaced by "-fPIC".
	sed -i -e 's/SHLIB_CFLAGS		= -fpic/SHLIB_CFLAGS		= /' linux.mk \
		&& einfo "Successfully applied sed script to patch linux.mk." \
		|| eerror "Failed to apply sed script to patch linux.mk."
	cd ${S}/src/mutlib
	cd ${S}
	echo


	einfo "Patching Staden Package code:"

	# "getopt" is incorrectly included as an extern (for Win32 compatibility).
	epatch ${FILESDIR}/${P}-getopt.patch

	# The "create_emboss_files" program needs more flexibility to respect the
	# Gentoo FSH.
	epatch ${FILESDIR}/${P}-emboss.patch

	# The original iwidgetsrc crashes...
	einfo 'Replacing broken iwidgetsrc'
	cp ${FILESDIR}/${P}-iwidgetsrc.new ${S}/tables/iwidgetsrc

	# Netscape is not a good default browser (security masked in Portage).
	# Use documentation.html rather than staden_home.html as the top-level
	# hypertext documentation file.
	einfo 'Replacing old staden_help script'
	cp ${FILESDIR}/${P}-staden_help.new ${S}/src/scripts/staden_help
	chmod +x ${S}/src/scripts/staden_help
	echo

	# The documentation building process is broken on Gentoo, mainly because
	# incorrect program locations are assumed.
	einfo "Patching Staden Package documentation build system:"

	# Documentation build process cannot find "update-nodes.el".
	cd ${S}/doc/manual/tools
	sed -i -e 's%emacs -batch $1 -l ${DOCDIR:-.}/tools/update-nodes.el%emacs -batch $1 -l ${DOCDIR:-..}/manual/tools/update-nodes.el%' update-nodes \
		&& einfo "Successfully applied sed script to patch update-nodes." \
		|| eerror "Failed to apply sed script to patch update-nodes."

	# Perl scripts search for "pearl" in "/usr/local".
	for SCRIPT in *.pl texi2html; do
		sed -i -e 's%/usr/local/bin/perl%/usr/bin/perl%' ${SCRIPT} \
			&& einfo "Successfully applied sed script to patch ${SCRIPT}." \
			|| eerror "Failed to apply sed script to patch ${SCRIPT}."
	done

	# The "convert" tool from Imagemagick is searched for in "/usr/X11R6".
	sed -i -e 's%/usr/X11R6/bin/convert%/usr/bin/convert%' make_ps \
		&& einfo "Successfully applied sed script to patch make.ps." \
		|| eerror "Failed to apply sed script to patch make.ps."

	# Solves issues with images in the exercise* texi files.
	cd ${S}/course/texi
	for FILE in exercise*.texi; do
		sed -i -e 's/,,8in}/,,8in,,eps}/' ${FILE} && \
			sed -i -e 's/,6in}/,6in,,,eps}/' ${FILE} \
			&& einfo "Successfully applied sed scripts to patch ${FILE}." \
			|| eerror "Failed to apply sed scripts to patch ${FILE}."
	done
	echo

	# "CFLAGS" and "FFLAGS" need to be set to the user's values in the build
	# system global Makefile. We also want only "-fPIC" shared libraries.
	einfo "Applying user-defined compilation/linking flags:"
	cd ${S}/src/mk
	sed -i -e "s/COPT		= -O2 -g3 -DNDEBUG/COPT = ${CFLAGS:-"-O2 -g3 -DNDEBUG"} -fPIC/" global.mk \
		&& einfo "Successfully applied sed script to set CFLAGS." \
		|| eerror "Failed to apply sed script to set CFLAGS."
	sed -i -e "s/FOPT		= -O2 -g3 -DNDEBUG/FOPT = ${FFLAGS:-"-O2 -g3 -DNDEBUG"} -fPIC/" global.mk \
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

	# Compile executables and libraries.
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

	# Build documentation.
	cd ${S}/doc
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
	cd ${S}
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
	# containing the appropriate libraries. Remove libread since an updated
	# version is included in "dev-libs/io_lib".
	rm ${S}/lib/linux-binaries
	rm ${S}/src/lib/linux-binaries/libread.so
	mkdir ${S}/lib/linux-binaries
	cp ${S}/src/lib/linux-binaries/* ${S}/lib/linux-binaries

	# Delete the binaries already included in "dev-libs/io_lib".
	for FILE in convert_trace \
		extract_seq \
		get_comment \
		index_tar \
		makeSCF \
		scf_{dump,info,update} \
		trace_dump; do
		rm ${S}/linux-bin/${FILE}
	done

	# These won't be found if they are not symlinked in the lib dir.
	ln -s /usr/$(get_libdir)/libitcl3.2.so ${S}/lib/itcl3.3/libitcl3.3.so
	ln -s /usr/$(get_libdir)/libitk3.2.so ${S}/lib/itk3.3/libitk3.3.so

	# Remove the prebuilt EMBOSS tcl/tk GUIs.
	rm ${S}/tables/emboss_menu
	rm -r ${S}/lib/spin2_emboss/acdtcl
	rm -r ${S}/lib/spin_emboss/acdtcl

	# Patch just built hypertext documentation.
	cd ${S}/doc/manual
	for FILE in *.html; do
		sed -i -e 's%<a href="../staden_home.html"><img src="i/nav_home.gif" alt="home"></a>%%' ${FILE}
	done
	cd ${S}/doc/scripting_manual
	for FILE in *.html; do
		sed -i -e 's%<a href="../staden_home.html"><img src="i/nav_home.gif" alt="home"></a>%%' ${FILE}
	done
}

src_install() {
	# Executables and libraries
	mkdir -p ${D}/opt/${PN}

	for FILE in ${S}/src/lib/linux-binaries/*; do
		dolib ${FILE}
	done

	mv ${S}/linux-bin ${D}/opt/${PN}/linux-bin
	mv ${S}/lib ${D}/opt/${PN}/lib

	# Shared files
	mv ${S}/demo ${D}/opt/${PN}
	mv ${S}/tables ${D}/opt/${PN}
	mv ${S}/userdata ${D}/opt/${PN}

	# "env" file for setting paths to Staden Package root, libraries, tables...
	insinto /etc/env.d
	newins ${FILESDIR}/${P}-env 27${PN}

	# Basic documentation
	insinto /opt/${PN}/doc
	doins ${S}/{ChangeLog,doc/Acknowledgements}
	newins ${S}/doc/emboss.txt README.emboss

	# Man pages
	doman ${S}/doc/manual/man/man*/*

	# Hypertext documentation
	insinto /opt/${PN}/doc/manual
	doins ${S}/doc/manual/*unix*.{gif,html,index}
	insinto /opt/${PN}/doc/scripting_manual
	doins ${S}/doc/scripting_manual/*.html
	insinto /opt/${PN}/doc/manual/i
	doins ${S}/doc/manual/i/*
	insinto /opt/${PN}/doc/scripting_manual/i
	doins ${S}/doc/scripting_manual/i/*

	# Missing hypertext documentation
	insinto /opt/${PN}/doc
	doins ${WORKDIR}/${P}-missing-doc/documentation.html
	insinto /opt/${PN}/doc/misc
	doins ${WORKDIR}/${P}-missing-doc/misc/*
	insinto /opt/${PN}/doc/misc/i
	doins ${S}/doc/manual/i/*

	# Printable manuals and articles
	insinto /opt/${PN}/doc
	newins ${S}/doc/gkb547_gml.pdf Staden1998.pdf
	newins ${S}/doc/manual/manual_unix.dvi manual.dvi
	newins ${S}/doc/manual/manual_unix.ps manual.ps
	newins ${S}/doc/manual/mini_unix.ps mini_manual.ps
	newins ${S}/doc/scripting_manual/scripting.dvi scripting_manual.dvi
	newins ${S}/doc/scripting_manual/scripting.ps scripting_manual.ps

	# A short course in printable format, along with example data
	if use doc; then
		mkdir -p ${D}/opt/${PN}/course
		mv ${WORKDIR}/course-1.1/data ${D}/opt/${PN}/course/data
		insinto /opt/${PN}/course
		doins ${WORKDIR}/course-1.1/README
		newins ${WORKDIR}/course-1.1/unix_docs/mutation_talk.ppt course_mutation_detection_diapos.pdf
		newins ${WORKDIR}/course-1.1/unix_docs/course_unix.pdf course_project_management.pdf
		newins ${WORKDIR}/course-1.1/unix_docs/mutation_notes.pdf course_mutation_detection.pdf
	fi
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
	echo
}
