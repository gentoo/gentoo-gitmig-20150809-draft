# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/qt4-build.eclass,v 1.55 2009/12/22 16:04:13 abcd Exp $

# @ECLASS: qt4-build.eclass
# @MAINTAINER:
# Ben de Groot <yngwin@gentoo.org>,
# Markos Chandras <hwoarang@gentoo.org>,
# Caleb Tennis <caleb@gentoo.org>
# Alex Alexander <wired@gentoo.org>
# @BLURB: Eclass for Qt4 split ebuilds.
# @DESCRIPTION:
# This eclass contains various functions that are used when building Qt4

inherit base eutils multilib toolchain-funcs flag-o-matic versionator

IUSE="debug pch"
RDEPEND="
	!<x11-libs/qt-assistant-${PV}
	!>x11-libs/qt-assistant-${PV}-r9999
	!<x11-libs/qt-core-${PV}
	!>x11-libs/qt-core-${PV}-r9999
	!<x11-libs/qt-dbus-${PV}
	!>x11-libs/qt-dbus-${PV}-r9999
	!<x11-libs/qt-demo-${PV}
	!>x11-libs/qt-demo-${PV}-r9999
	!<x11-libs/qt-gui-${PV}
	!>x11-libs/qt-gui-${PV}-r9999
	!<x11-libs/qt-opengl-${PV}
	!>x11-libs/qt-opengl-${PV}-r9999
	!<x11-libs/qt-phonon-${PV}
	!>x11-libs/qt-phonon-${PV}-r9999
	!<x11-libs/qt-qt3support-${PV}
	!>x11-libs/qt-qt3support-${PV}-r9999
	!<x11-libs/qt-script-${PV}
	!>x11-libs/qt-script-${PV}-r9999
	!<x11-libs/qt-sql-${PV}
	!>x11-libs/qt-sql-${PV}-r9999
	!<x11-libs/qt-svg-${PV}
	!>x11-libs/qt-svg-${PV}-r9999
	!<x11-libs/qt-test-${PV}
	!>x11-libs/qt-test-${PV}-r9999
	!<x11-libs/qt-webkit-${PV}
	!>x11-libs/qt-webkit-${PV}-r9999
	!<x11-libs/qt-xmlpatterns-${PV}
	!>x11-libs/qt-xmlpatterns-${PV}-r9999
"

MY_PV=${PV/_/-}

if version_is_at_least 4.5.99999999 ${PV} ; then
	MY_P=qt-everywhere-opensource-src-${MY_PV}
else
	MY_P=qt-x11-opensource-src-${MY_PV}
fi

S=${WORKDIR}/${MY_P}

HOMEPAGE="http://qt.nokia.com/"
SRC_URI="http://get.qt.nokia.com/qt/source/${MY_P}.tar.gz"

LICENSE="|| ( LGPL-2.1 GPL-3 )"

# @FUNCTION: qt4-build_pkg_setup
# @DESCRIPTION:
# Sets up PATH and LD_LIBRARY_PATH
qt4-build_pkg_setup() {
	PATH="${S}/bin${PATH:+:}${PATH}"
	LD_LIBRARY_PATH="${S}/lib${LD_LIBRARY_PATH:+:}${LD_LIBRARY_PATH}"

	# Make sure ebuilds use the required EAPI
	if [[ ${EAPI} != 2 ]]; then
		eerror "The qt4-build eclass requires EAPI=2, but this ebuild does not"
		eerror "have EAPI=2 set. The ebuild author or editor failed. This ebuild needs"
		eerror "to be fixed. Using qt4-build-edge eclass without EAPI=2 will fail."
		die "qt4-build-edge eclass requires EAPI=2"
	fi

	if ! version_is_at_least 4.1 $(gcc-version); then
		ewarn "Using a GCC version lower than 4.1 is not supported!"
		echo
		ebeep 3
	fi

	if [[ ${P} == qt-core-4.6.0_rc1 ]]; then
		ewarn
		ewarn "Binary compatibility broke between 4.6.0_beta1 and 4.6.0_rc1."
		ewarn "If you are upgrading from 4.6.0_beta1, you'll have to"
		ewarn "re-emerge everything that depends on Qt."
		ewarn "Use the following command:"
		ewarn
		ewarn "   emerge -av1 \$(for i in \$(qlist -IC x11-libs/qt-);"
		ewarn "   do equery -q d \$i | grep -v 'x11-libs/qt-' |"
		ewarn "   sed \"s/^/=/\"; done)"
		ewarn
		ewarn "YOU'VE BEEN WARNED"
		ewarn
		ebeep 3
	fi

}

# @ECLASS-VARIABLE: QT4_TARGET_DIRECTORIES
# @DESCRIPTION:
# Arguments for build_target_directories. Takes the directories, in which the
# code should be compiled. This is a space-separated list

# @ECLASS-VARIABLE: QT4_EXTRACT_DIRECTORIES
# @DESCRIPTION:
# Space separated list including the directories that will be extracted from Qt
# tarball

# @FUNCTION: qt4-build_src_unpack
# @DESCRIPTION:
# Unpacks the sources
qt4-build_src_unpack() {
	setqtenv
	local target targets=
	for target in configure LICENSE.GPL3 LICENSE.LGPL projects.pro \
		src/{qbase,qt_targets,qt_install}.pri bin config.tests mkspecs qmake \
		${QT4_EXTRACT_DIRECTORIES}; do
			targets+=" ${MY_P}/${target}"
	done

	echo tar xzpf "${DISTDIR}"/${MY_P}.tar.gz ${targets}
	tar xzpf "${DISTDIR}"/${MY_P}.tar.gz ${targets}
}

# @ECLASS-VARIABLE: PATCHES
# @DESCRIPTION:
# In case you have patches to apply, specify them in PATCHES variable. Make sure
# to specify the full path. This variable is necessary for src_prepare phase.
# example:
# PATCHES="${FILESDIR}"/mypatch.patch
#   ${FILESDIR}"/mypatch2.patch"
#

# @FUNCTION: qt4-build_src_prepare
# @DESCRIPTION:
# Prepare the sources before the configure phase. Strip CFLAGS if necessary, and fix
# source files in order to respect CFLAGS/CXXFLAGS/LDFLAGS specified on /etc/make.conf.
qt4-build_src_prepare() {
	setqtenv
	cd "${S}"

	if [[ ${PN} != qt-core ]]; then
		skip_qmake_build_patch
		skip_project_generation_patch
		symlink_binaries_to_buildtree
	fi

	# Bug 282984 && Bug 295530
	sed -e "s:\(^SYSTEM_VARIABLES\):CC=$(tc-getCC)\nCXX=$(tc-getCXX)\n\1:" \
		-i configure || die "sed qmake compilers failed"
	sed -e "s:\(\$MAKE\):\1 CC=$(tc-getCC) CXX=$(tc-getCXX) LD=$(tc-getCXX):" \
		-i config.tests/unix/compile.test || die "sed test compilers failed"

	# Bug 178652
	if [[ $(gcc-major-version) == 3 ]] && use amd64; then
		ewarn "Appending -fno-gcse to CFLAGS/CXXFLAGS"
		append-flags -fno-gcse
	fi

	# Unsupported old gcc versions - hardened needs this :(
	if [[ $(gcc-major-version) -lt 4 ]] ; then
		ewarn "Appending -fno-stack-protector to CXXFLAGS"
		append-cxxflags -fno-stack-protector
		# Bug 253127
		sed -e "/^QMAKE_CFLAGS\t/ s:$: -fno-stack-protector-all:" \
		-i "${S}"/mkspecs/common/g++.conf || die "sed ${S}/mkspecs/common/g++.conf failed"
	fi

	# Bug 261632
	if use ppc64; then
		ewarn "Appending -mminimal-toc to CFLAGS/CXXFLAGS"
		append-flags -mminimal-toc
	fi

	# Bug 172219
	sed -e "s:QMAKE_CFLAGS_RELEASE.*=.*:QMAKE_CFLAGS_RELEASE=${CFLAGS}:" \
		-e "s:QMAKE_CXXFLAGS_RELEASE.*=.*:QMAKE_CXXFLAGS_RELEASE=${CXXFLAGS}:" \
		-e "s:QMAKE_LFLAGS_RELEASE.*=.*:QMAKE_LFLAGS_RELEASE=${LDFLAGS}:" \
		-e "s:X11R6/::" \
		-i "${S}"/mkspecs/$(qt_mkspecs_dir)/qmake.conf || die "sed ${S}/mkspecs/$(qt_mkspecs_dir)/qmake.conf failed"

	sed -e "s:QMAKE_CFLAGS_RELEASE.*=.*:QMAKE_CFLAGS_RELEASE=${CFLAGS}:" \
		-e "s:QMAKE_CXXFLAGS_RELEASE.*=.*:QMAKE_CXXFLAGS_RELEASE=${CXXFLAGS}:" \
		-e "s:QMAKE_LFLAGS_RELEASE.*=.*:QMAKE_LFLAGS_RELEASE=${LDFLAGS}:" \
		-i "${S}"/mkspecs/common/g++.conf || die "sed ${S}/mkspecs/common/g++.conf failed"

	base_src_prepare
}

# @FUNCTION: qt4-build_src_configure
# @DESCRIPTION:
# Default configure phase
qt4-build_src_configure() {
	setqtenv
	myconf="$(standard_configure_options) ${myconf}"

	echo ./configure ${myconf}
	./configure ${myconf} || die "./configure failed"
	myconf=""
}

# @FUNCTION: qt4-build_src_compile
# @DESCRIPTION: Actual compile phase
qt4-build_src_compile() {
	setqtenv

	build_directories ${QT4_TARGET_DIRECTORIES}
}

# @FUNCTION: qt4-build_src_install
# @DESCRIPTION:
# Perform the actual installation including some library fixes.
qt4-build_src_install() {
	setqtenv
	install_directories ${QT4_TARGET_DIRECTORIES}
	install_qconfigs
	fix_library_files
}

# @FUNCTION: setqtenv
setqtenv() {
	# Set up installation directories
	QTBASEDIR=/usr/$(get_libdir)/qt4
	QTPREFIXDIR=/usr
	QTBINDIR=/usr/bin
	QTLIBDIR=/usr/$(get_libdir)/qt4
	QMAKE_LIBDIR_QT=${QTLIBDIR}
	QTPCDIR=/usr/$(get_libdir)/pkgconfig
	QTDATADIR=/usr/share/qt4
	QTDOCDIR=/usr/share/doc/qt-${PV}
	QTHEADERDIR=/usr/include/qt4
	QTPLUGINDIR=${QTLIBDIR}/plugins
	QTSYSCONFDIR=/etc/qt4
	QTTRANSDIR=${QTDATADIR}/translations
	QTEXAMPLESDIR=${QTDATADIR}/examples
	QTDEMOSDIR=${QTDATADIR}/demos
	QT_INSTALL_PREFIX=/usr/$(get_libdir)/qt4
	PLATFORM=$(qt_mkspecs_dir)

	unset QMAKESPEC
}

# @FUNCTION: standard_configure_options
# @DESCRIPTION:
# Sets up some standard configure options, like libdir (if necessary), whether
# debug info is wanted or not.
standard_configure_options() {
	local myconf=

	[[ $(get_libdir) != lib ]] && myconf+=" -L/usr/$(get_libdir)"

	# Disable visibility explicitly if gcc version isn't 4
	if [[ $(gcc-major-version) -lt 4 ]]; then
		myconf+=" -no-reduce-exports"
	fi

	# precompiled headers doesn't work on hardened, where the flag is masked.
	myconf+=" $(qt_use pch)"

	if use debug; then
		myconf+=" -debug"
	else
		myconf+=" -release"
	fi
	myconf+=" -no-separate-debug-info"

	# ARCH is set on Gentoo. Qt now falls back to generic on an unsupported
	# $(tc-arch). Therefore we convert it to supported values.
	case "$(tc-arch)" in
		amd64) myconf+=" -arch x86_64" ;;
		ppc|ppc64) myconf+=" -arch powerpc" ;;
		x86|x86-*) myconf+=" -arch i386" ;;
		alpha|arm|ia64|mips|s390|sparc) myconf+=" -arch $(tc-arch)" ;;
		hppa|sh) myconf+=" -arch generic" ;;
		*) die "$(tc-arch) is unsupported by this eclass. Please file a bug." ;;
	esac

	# 4.6: build qt-core with exceptions or qt-xmlpatterns won't build
	local exceptions=
	case "${PV}" in
		4.6.*)
			if [[ ${PN} != "qt-core" ]] && [[ ${PN} != "qt-xmlpatterns" ]]; then
				exceptions="-no-exceptions"
			fi
		;;
		*)
			[[ ${PN} == "qt-xmlpatterns" ]] || exceptions="-no-exceptions"
		;;
	esac

	myconf+=" -platform $(qt_mkspecs_dir) -stl -verbose -largefile -confirm-license
		-prefix ${QTPREFIXDIR} -bindir ${QTBINDIR} -libdir ${QTLIBDIR}
		-datadir ${QTDATADIR} -docdir ${QTDOCDIR} -headerdir ${QTHEADERDIR}
		-plugindir ${QTPLUGINDIR} -sysconfdir ${QTSYSCONFDIR}
		-translationdir ${QTTRANSDIR} -examplesdir ${QTEXAMPLESDIR}
		-demosdir ${QTDEMOSDIR} -silent -fast -opensource
		${exceptions}
		-reduce-relocations -nomake examples -nomake demos"

	echo "${myconf}"
}

# @FUNCTION: build_directories
# @USAGE: < directories >
# @DESCRIPTION:
# Compiles the code in $QT4_TARGET_DIRECTORIES
build_directories() {
	for x in "$@"; do
		cd "${S}"/${x}
		sed -i -e "s:\$\$\[QT_INSTALL_LIBS\]:/usr/$(get_libdir)/qt4:g" $(find "${S}" -name '*.pr[io]') "${S}"/mkspecs/common/linux.conf || die
		"${S}"/bin/qmake "LIBS+=-L${QTLIBDIR}" "CONFIG+=nostrip" || die "qmake failed"
		emake CC="@echo compiling \$< && $(tc-getCC)" \
			CXX="@echo compiling \$< && $(tc-getCXX)" \
			LINK="@echo linking \$@ && $(tc-getCXX)" || die "emake failed"
	done
}

# @FUNCTION: install_directories
# @USAGE: < directories >
# @DESCRIPTION:
# run emake install in the given directories, which are separated by spaces
install_directories() {
	for x in "$@"; do
		pushd "${S}"/${x} >/dev/null || die "Can't pushd ${S}/${x}"
		emake INSTALL_ROOT="${D}" install || die "emake install failed"
		popd >/dev/null || die "Can't popd from ${S}/${x}"
	done
}

# @ECLASS-VARIABLE: QCONFIG_ADD
# @DESCRIPTION:
# List options that need to be added to QT_CONFIG in qconfig.pri
: ${QCONFIG_ADD:=}

# @ECLASS-VARIABLE: QCONFIG_REMOVE
# @DESCRIPTION:
# List options that need to be removed from QT_CONFIG in qconfig.pri
: ${QCONFIG_REMOVE:=}

# @ECLASS-VARIABLE: QCONFIG_DEFINE
# @DESCRIPTION:
# List variables that should be defined at the top of QtCore/qconfig.h
: ${QCONFIG_DEFINE:=}

# @FUNCTION: install_qconfigs
# @DESCRIPTION: Install gentoo-specific mkspecs configurations
install_qconfigs() {
	local x
	if [[ -n ${QCONFIG_ADD} || -n ${QCONFIG_REMOVE} ]]; then
		for x in QCONFIG_ADD QCONFIG_REMOVE; do
			[[ -n ${!x} ]] && echo ${x}=${!x} >> "${T}"/${PN}-qconfig.pri
		done
		insinto ${QTDATADIR}/mkspecs/gentoo
		doins "${T}"/${PN}-qconfig.pri || die "installing ${PN}-qconfig.pri failed"
	fi

	if [[ -n ${QCONFIG_DEFINE} ]]; then
		for x in ${QCONFIG_DEFINE}; do
			echo "#define ${x}" >> "${T}"/gentoo-${PN}-qconfig.h
		done
		insinto ${QTHEADERDIR}/Gentoo
		doins "${T}"/gentoo-${PN}-qconfig.h || die "installing ${PN}-qconfig.h failed"
	fi
}

# @FUNCTION: generate_qconfigs
# @DESCRIPTION: Generates gentoo-specific configurations
generate_qconfigs() {
	if [[ -n ${QCONFIG_ADD} || -n ${QCONFIG_REMOVE} || -n ${QCONFIG_DEFINE} || ${CATEGORY}/${PN} == x11-libs/qt-core ]]; then
		local x qconfig_add qconfig_remove qconfig_new
		for x in "${ROOT}${QTDATADIR}"/mkspecs/gentoo/*-qconfig.pri; do
			[[ -f ${x} ]] || continue
			qconfig_add+=" $(sed -n 's/^QCONFIG_ADD=//p' "${x}")"
			qconfig_remove+=" $(sed -n 's/^QCONFIG_REMOVE=//p' "${x}")"
		done

		# these error checks do not use die because dying in pkg_post{inst,rm}
		# just makes things worse.
		if [[ -e "${ROOT}${QTDATADIR}"/mkspecs/gentoo/qconfig.pri ]]; then
			# start with the qconfig.pri that qt-core installed
			if ! cp "${ROOT}${QTDATADIR}"/mkspecs/gentoo/qconfig.pri \
				"${ROOT}${QTDATADIR}"/mkspecs/qconfig.pri; then
				eerror "cp qconfig failed."
				return 1
			fi

			# generate list of QT_CONFIG entries from the existing list
			# including qconfig_add and excluding qconfig_remove
			for x in $(sed -n 's/^QT_CONFIG +=//p' \
				"${ROOT}${QTDATADIR}"/mkspecs/qconfig.pri) ${qconfig_add}; do
					hasq ${x} ${qconfig_remove} || qconfig_new+=" ${x}"
			done

			# replace the existing QT_CONFIG list with qconfig_new
			if ! sed -i -e "s/QT_CONFIG +=.*/QT_CONFIG += ${qconfig_new}/" \
				"${ROOT}${QTDATADIR}"/mkspecs/qconfig.pri; then
				eerror "Sed for QT_CONFIG failed"
				return 1
			fi

			# create Gentoo/qconfig.h
			if [[ ! -e ${ROOT}${QTHEADERDIR}/Gentoo ]]; then
				if ! mkdir -p "${ROOT}${QTHEADERDIR}"/Gentoo; then
					eerror "mkdir ${QTHEADERDIR}/Gentoo failed"
					return 1
				fi
			fi
			: > "${ROOT}${QTHEADERDIR}"/Gentoo/gentoo-qconfig.h
			for x in "${ROOT}${QTHEADERDIR}"/Gentoo/gentoo-*-qconfig.h; do
				[[ -f ${x} ]] || continue
				cat "${x}" >> "${ROOT}${QTHEADERDIR}"/Gentoo/gentoo-qconfig.h
			done
		else
			rm -f "${ROOT}${QTDATADIR}"/mkspecs/qconfig.pri
			rm -f "${ROOT}${QTHEADERDIR}"/Gentoo/gentoo-qconfig.h
			rmdir "${ROOT}${QTDATADIR}"/mkspecs \
				"${ROOT}${QTDATADIR}" \
				"${ROOT}${QTHEADERDIR}"/Gentoo \
				"${ROOT}${QTHEADERDIR}" 2>/dev/null
		fi
	fi
}

# @FUNCTION: qt4-build_pkg_postrm
# @DESCRIPTION: Generate configurations when the package is completely removed
qt4-build_pkg_postrm() {
	generate_qconfigs
}

# @FUNCTION: qt4-build_pkg_postinst
# @DESCRIPTION: Generate configuration, plus throws a message about possible
# breakages and proposed solutions.
qt4-build_pkg_postinst() {
	generate_qconfigs

	if [[ "${PN}" == "qt-core" ]]; then
		echo
		ewarn "After a rebuild or upgrade of Qt, it can happen that Qt plugins (such as Qt"
		ewarn "and KDE styles and widgets) can no longer be loaded. In this situation you"
		ewarn "should recompile the packages providing these plugins. Also, make sure you"
		ewarn "compile the Qt packages, and the packages that depend on it, with the same"
		ewarn "GCC version and the same USE flag settings (especially the debug flag)."
		ewarn
		ewarn "Packages that typically need to be recompiled are kdelibs from KDE4, any"
		ewarn "additional KDE4/Qt4 styles, qscintilla and PyQt4. Before filing a bug report,"
		ewarn "make sure all your Qt4 packages are up-to-date and built with the same"
		ewarn "configuration."
		ewarn
		ewarn "For more information, see http://doc.trolltech.com/${PV%.*}/plugins-howto.html"
		echo
	fi
}

# @FUNCTION: skip_qmake_build_patch
# @DESCRIPTION:
# Don't need to build qmake, as it's already installed from qt-core
skip_qmake_build_patch() {
	# Don't need to build qmake, as it's already installed from qt-core
	sed -i -e "s:if true:if false:g" "${S}"/configure || die "Sed failed"
}

# @FUNCTION: skip_project_generation_patch
# @DESCRIPTION:
# Exit the script early by throwing in an exit before all of the .pro files are scanned
skip_project_generation_patch() {
	# Exit the script early by throwing in an exit before all of the .pro files are scanned
	sed -e "s:echo \"Finding:exit 0\n\necho \"Finding:g" \
		-i "${S}"/configure || die "Sed failed"
}

# @FUNCTION: symlink_binaries_to_buildtree
# @DESCRIPTION:
# Symlink generated binaries to buildtree so they can be used during compilation
# time
symlink_binaries_to_buildtree() {
	for bin in qmake moc uic rcc; do
		ln -s ${QTBINDIR}/${bin} "${S}"/bin/ || die "Symlinking ${bin} to ${S}/bin failed."
	done
}

# @FUNCTION: fix_library_files
# @DESCRIPTION:
# Fixes the pathes in *.la, *.prl, *.pc, as they are wrong due to sandbox and
# moves the *.pc-files into the pkgconfig directory
fix_library_files() {
	for libfile in "${D}"/${QTLIBDIR}/{*.la,*.prl,pkgconfig/*.pc}; do
		if [[ -e ${libfile} ]]; then
			sed -i -e "s:${S}/lib:${QTLIBDIR}:g" ${libfile} || die "Sed on ${libfile} failed."
		fi
	done

	# pkgconfig files refer to WORKDIR/bin as the moc and uic locations.  Fix:
	for libfile in "${D}"/${QTLIBDIR}/pkgconfig/*.pc; do
		if [[ -e ${libfile} ]]; then
			sed -i -e "s:${S}/bin:${QTBINDIR}:g" ${libfile} || die "Sed failed"

		# Move .pc files into the pkgconfig directory
		dodir ${QTPCDIR}
		mv ${libfile} "${D}"/${QTPCDIR}/ \
			|| die "Moving ${libfile} to ${D}/${QTPCDIR}/ failed."
		fi
	done

	# Don't install an empty directory
	rmdir "${D}"/${QTLIBDIR}/pkgconfig
}

# @FUNCTION: qt_use
# @USAGE: < flag > [ feature ] [ enableval ]
# @DESCRIPTION:
# This will echo "${enableval}-${feature}" if <flag> is enabled, or
# "-no-${feature} if the flag is disabled. If [feature] is not specified <flag>
# will be used for that. If [enableval] is not specified, it omits the
# assignment-part
qt_use() {
	local flag=$1
	local feature=$1
	local enableval=

	[[ -n $2 ]] && feature=$2
	[[ -n $3 ]] && enableval=-$3

	if use ${flag}; then
		echo "${enableval}-${feature}"
	else
		echo "-no-${feature}"
	fi
}

# @FUNCTION: qt_mkspecs_dir
# @RETURN: the specs-directory w/o path
# @DESCRIPTION:
# Allows us to define which mkspecs dir we want to use.
qt_mkspecs_dir() {
	# Allows us to define which mkspecs dir we want to use.
	local spec

	case ${CHOST} in
		*-freebsd*|*-dragonfly*)
			spec=freebsd ;;
		*-openbsd*)
			spec=openbsd ;;
		*-netbsd*)
			spec=netbsd ;;
		*-darwin*)
			spec=darwin ;;
		*-linux-*|*-linux)
			spec=linux ;;
		*)
			die "Unknown CHOST, no platform choosen."
	esac

	CXX=$(tc-getCXX)
	if [[ ${CXX} == *g++* ]]; then
		spec+=-g++
	elif [[ ${CXX} == *icpc* ]]; then
		spec+=-icc
	else
		die "Unknown compiler ${CXX}."
	fi
	if [[ -n ${LIBDIR/lib} ]]; then
		spec+=-${LIBDIR/lib}
	fi

	echo "${spec}"
}

EXPORT_FUNCTIONS pkg_setup src_unpack src_prepare src_configure src_compile src_install pkg_postrm pkg_postinst
