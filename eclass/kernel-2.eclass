# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/kernel-2.eclass,v 1.59 2004/12/02 20:34:29 dsd Exp $

# Description: kernel.eclass rewrite for a clean base regarding the 2.6
#              series of kernel with back-compatibility for 2.4
#
# Maintainer: John Mylchreest <johnm@gentoo.org>
# Copyright 2004 Gentoo Linux
#
# Please direct your bugs to the current eclass maintainer :)

# added functionality:
# unipatch		- a flexible, singular method to extract, add and remove patches.

# A Couple of env vars are available to effect usage of this eclass
# These are as follows:
#
# K_NOSETEXTRAVERSION	- if this is set then EXTRAVERSION will not be
#						  automatically set within the kernel Makefile
# K_NOUSENAME			- if this is set then EXTRAVERSION will not include the
#						  first part of ${PN} in EXTRAVERSION
# K_PREPATCHED			- if the patchset is prepatched (ie: mm-sources, 
#						  ck-sources, ac-sources) it will use PR (ie: -r5) as 
#						  the patchset version for 
#						- and not use it as a true package revision
# K_EXTRAEINFO			- this is a new-line seperated list of einfo displays in
#						  postinst and can be used to carry additional postinst 
#						  messages
# K_EXTRAEWARN			- same as K_EXTRAEINFO except ewarn's instead of einfo's

# H_SUPPORTEDARCH		- this should be a space separated list of ARCH's which
#						  can be supported by the headers ebuild

# UNIPATCH_LIST			- space delimetered list of patches to be applied to the
#						  kernel
# UNIPATCH_EXCLUDE		- an addition var to support exlusion based completely
#						  on "<passedstring>*" and not "<passedno#>_*"
#						- this should _NOT_ be used from the ebuild as this is 
#						  reserved for end users passing excludes from the cli
# UNIPATCH_DOCS			- space delimemeted list of docs to be installed to 
#						  the doc dir
# UNIPATCH_STRICTORDER	- if this is set places patches into directories of 
#						  order, so they are applied in the order passed

ECLASS="kernel-2"
INHERITED="$INHERITED $ECLASS"
EXPORT_FUNCTIONS pkg_setup src_unpack src_compile src_install pkg_preinst pkg_postinst

HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/" 
LICENSE="GPL-2"
IUSE="${IUSE} build doc"
SLOT="${PVR}"

# set LINUX_HOSTCFLAGS if not already set
[ -z "$LINUX_HOSTCFLAGS" ] && LINUX_HOSTCFLAGS="-Wall -Wstrict-prototypes -Os -fomit-frame-pointer -I${S}/include"

#Eclass functions only from here onwards ...
#==============================================================
kernel_is() {
	local RESULT
	RESULT=1
	
	if [ -n "${1}" ]
	then
		[ "${1}" = "${KV_MAJOR}" ] && RESULT=0
	fi
	
	if [ -n "${2}" ]
	then
		RESULT=1
		[ "${2}" = "${KV_MINOR}" ] && RESULT=0
	fi
	
	if [ -n "${3}" ]
	then
		RESULT=1
		[ "${3}" = "${KV_PATCH}" ] && RESULT=0
	fi
	return ${RESULT}
}

kernel_is_2_4() {
	kernel_is 2 4
	return $?
}

kernel_is_2_6() {
	[ ${KV_MAJOR} -eq 2 -a ${KV_MINOR} -eq 5 -o ${KV_MINOR} -eq 6 ] && \
		return 0 || return 1
}

# Capture the sources type and set DEPENDs
if [ "${ETYPE}" == "sources" ]
then
	# binutils version needed to avoid Athlon/PIII/SSE assembler bugs.
	DEPEND="!build? ( sys-apps/sed
			>=sys-devel/binutils-2.11.90.0.31 )
			doc? ( !arm? ( !s390? ( app-text/docbook-sgml-utils ) ) )"

	RDEPEND="${DEPEND}
		 	 !build? ( >=sys-libs/ncurses-5.2
			 dev-lang/perl
			 sys-apps/module-init-tools
			 sys-devel/make )"
		
	[ $(kernel_is_2_4) $? == 0 ] && PROVIDE="virtual/linux-sources" \
		|| PROVIDE="virtual/linux-sources virtual/alsa"

elif [ "${ETYPE}" == "headers" ]
then
	PROVIDE="virtual/kernel virtual/os-headers"
else
	eerror "Unknown ETYPE=\"${ETYPE}\", must be \"sources\" or \"headers\""
	die
fi

# Unpack functions
#==============================================================
unpack_2_4() {
	cd ${S}
	# this file is required for other things to build properly, 
	# so we autogenerate it
	make mrproper || die "make mrproper died"
	make include/linux/version.h || die "make include/linux/version.h failed"
	echo ">>> version.h compiled successfully."
}

universal_unpack() {
	[ -z "${OKV}" ] && OKV="${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}"

	cd ${WORKDIR}
	unpack linux-${OKV}.tar.bz2
	if [ "${OKV}" != "${KV_FULL}" ]
	then
		mv linux-${OKV} linux-${KV_FULL} \
			|| die "Unable to move source tree to ${KV_FULL}."
	fi
	cd ${S}
	
	# change incorrect install path
	sed	-ie 's:#export\tINSTALL_PATH:export\tINSTALL_PATH:' Makefile
		
	# remove all backup files
	find . -iname "*~" -exec rm {} \; 2> /dev/null

	if [ -d "${S}/Documentation/DocBook" ]
	then
		cd ${S}/Documentation/DocBook
		sed -e "s:db2:docbook2:g" Makefile > Makefile.new \
			&& mv Makefile.new Makefile
		cd ${S}
	fi
}

unpack_set_extraversion() {
	cd ${S}
	sed -ie "s:^\(EXTRAVERSION =\).*:\1 ${EXTRAVERSION}:" Makefile
}

# Compile Functions
#==============================================================
compile_headers() {
	local MY_ARCH
	
	MY_ARCH=${ARCH}
	unset ${ARCH}
	yes "" | make oldconfig
	echo ">>> make oldconfig complete"
	ARCH=${MY_ARCH}	
}

compile_manpages() {
	local MY_ARCH

	einfo "Making manpages ..."
	MY_ARCH=${ARCH}
	unset ARCH
	make mandocs
	ARCH=${MY_ARCH}
}

# install functions
#==============================================================
install_universal() {
	#fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R root:root *
	chmod -R a+r-w+X,u+w *
}

install_headers() {
	[ $(kernel_is_2_4) $? == 0 ] && unpack_2_4
	
	cd ${S}
	dodir /usr/include/linux
	ln -sf ${S}/include/asm-${ARCH} ${S}/include/asm
	cp -ax ${S}/include/linux/* ${D}/usr/include/linux
	rm -rf ${D}/usr/include/linux/modules
	
	dodir /usr/include/asm
	cp -ax ${S}/include/asm/* ${D}/usr/include/asm
	
	if [ $(kernel_is_2_6) $? == 0 ]
	then
		dodir /usr/include/asm-generic
		cp -ax ${S}/include/asm-generic/* ${D}/usr/include/asm-generic
	fi
}

install_sources() {
	local doc
	local docs
	local file

	cd ${S}
	dodir /usr/src
	echo ">>> Copying sources ..."
	file="$(find ${WORKDIR} -iname "docs" -type d)"
	if [ -n "${file}" ]
	then
		for file in $(find ${file} -type f)
		do
			echo "${file/*docs\//}" >> ${S}/patches.txt
			echo "===================================================" >> ${S}/patches.txt
			cat ${file} >> ${S}/patches.txt
			echo "===================================================" >> ${S}/patches.txt
			echo "" >> ${S}/patches.txt
		done
	fi

	if [ ! -f ${S}/patches.txt ]
	then
		# patches.txt is empty so lets use our ChangeLog
		[ -f ${FILESDIR}/../ChangeLog ] && echo "Please check the ebuild ChangeLog for more details." > ${S}/patches.txt
	fi

	for doc in ${UNIPATCH_DOCS}
	do
		[ -f ${doc} ] && docs="${docs} ${doc}"
	done

	if [ -f ${S}/patches.txt ]; then
		docs="${docs} ${S}/patches.txt"
	fi

	if use doc && ! use arm && ! use s390; then
		install_manpages
	fi
	
	dodoc ${docs}
	mv ${WORKDIR}/linux* ${D}/usr/src
}

install_manpages() {
	local MY_ARCH

	ebegin "Installing manpages"
	MY_ARCH=${ARCH}
	unset ARCH
	sed -ie "s#/usr/local/man#${D}/usr/man#g" scripts/makeman
	make installmandocs
	eend $?
	sed -ie "s#${D}/usr/man#/usr/local/man#g" scripts/makeman
	ARCH=${MY_ARCH}
}

# pkg_preinst functions
#==============================================================
preinst_headers() {
	[ -L ${ROOT}usr/include/linux ] && rm ${ROOT}usr/include/linux
	[ -L ${ROOT}usr/include/asm ] && rm ${ROOT}usr/include/asm
}

# pkg_postinst functions
#==============================================================
postinst_sources() {
	if [ ! -h ${ROOT}usr/src/linux ]
	then
		ln -sf ${ROOT}usr/src/linux-${KV_FULL} ${ROOT}usr/src/linux
	fi

	# Don't forget to make directory for sysfs
	[ ! -d "${ROOT}/sys" -a $(kernel_is_2_6) $? == 0 ] && mkdir /sys

	echo
	einfo "After installing a new kernel of any version, it is important"
	einfo "that you have the appropriate /etc/modules.autoload.d/kernel-X.Y"
	einfo "created (X.Y is the first 2 parts of your new kernel version)"
	echo
	einfo "For example, this kernel will require:"
	einfo "/etc/modules.autoload.d/kernel-${KV_MAJOR}.${KV_MINOR}"
	echo
	
	# if K_EXTRAEINFO is set then lets display it now
	if [ -n "${K_EXTRAEINFO}" ]
	then
		echo ${K_EXTRAEINFO} | fmt |
		while read -s ELINE
		do
			einfo "${ELINE}"
		done

		echo
	fi

	# Show policy version, if this kernel has SELinux ...
	local secfile
	secfile="${ROOT}usr/src/linux-${KV_FULL}/security/selinux/include/security.h"
	if use selinux && [ -f "$secfile" ]
	then
		local polver=$(awk '/POLICYDB_VERSION /{print $3}' $secfile)
		einfo "The SELinux policy version of this kernel is $polver."
		echo
	fi

	# if K_EXTRAEWARN is set then lets display it now
	if [ -n "${K_EXTRAEWARN}" ]
	then
		echo ${K_EXTRAEWARN} | fmt |
		while read -s ELINE
		do
			ewarn "${ELINE}"
		done

		echo
	fi
}

postinst_headers() {
	echo
	einfo "Kernel headers are usually only used when recompiling glibc."
	einfo "Following the installation of newer headers it is advised that"
	einfo "you re-merge glibc as follows:"
	einfo "# emerge glibc"
	einfo "Failure to do so will cause glibc to not make use of newer"
	einfo "features present in the updated kernelheaders."
	echo
}

# pkg_setup functions
#==============================================================
setup_headers() {
	ARCH=$(uname -m | sed -e s/[i].86/i386/ -e s/x86/i386/ -e s/sun4u/sparc64/ \
	-e s/arm.*/arm/ -e s/sa110/arm/ -e s/amd64/x86_64/)
	[ "$ARCH" == "sparc" -a "$PROFILE_ARCH" == "sparc64" ] && ARCH="sparc64"
	
	[ -z "${H_SUPPORTEDARCH}" ] && H_SUPPORTEDARCH="${PN/-*/}"
	for i in ${H_SUPPORTEDARCH}
	do
		[ "${ARCH}" == "${i}" ] && H_ACCEPT_ARCH="yes"
	done
	
	if [ "${H_ACCEPT_ARCH}" != "yes" ]
	then
		echo
		eerror "This version of ${PN} does not support ${ARCH}."
		eerror "Please merge the appropriate sources, in most cases"
		eerror "this will be ${ARCH}-headers."
		die "incorrect headers"
	fi
}

# unipatch
#==============================================================
unipatch() {
	local i
	local x
	local extention
	local PIPE_CMD
	local UNIPATCH_DROP
	local KPATCH_DIR
	local PATCH_DEPTH
	local ELINE
	local STRICT_COUNT
	local PATCH_LEVEL

	[ -z "${KPATCH_DIR}" ] && KPATCH_DIR="${WORKDIR}/patches/"
	[ ! -d ${KPATCH_DIR} ] && mkdir -p ${KPATCH_DIR}

	# We're gonna need it when doing patches with a predefined patchlevel
	shopt -s extglob

	# This function will unpack all passed tarballs, add any passed patches, and remove any passed patchnumbers
	# usage can be either via an env var or by params
	# although due to the nature we pass this within this eclass
	# it shall be by param only.
	# -z "${UNIPATCH_LIST}" ] && UNIPATCH_LIST="${@}"
	UNIPATCH_LIST="${@}"

	#unpack any passed tarballs
	for i in ${UNIPATCH_LIST}
	do
		if [ -n "$(echo ${i} | grep -e "\.tar" -e "\.tbz" -e "\.tgz")" ]
		then
			extention=${i/*./}
			extention=${extention/:*/}
			case ${extention} in
				tbz2) PIPE_CMD="tar -xvjf";;
				 bz2) PIPE_CMD="tar -xvjf";;
				 tgz) PIPE_CMD="tar -xvzf";;
				  gz) PIPE_CMD="tar -xvzf";;
				   *) eerror "Unrecognized tarball compression"
				      die "Unrecognized tarball compression";;
			esac

			if [ -n "${UNIPATCH_STRICTORDER}" ]
			then
				STRICT_COUNT=$((${STRICT_COUNT} + 1))
				mkdir -p ${KPATCH_DIR}/${STRICT_COUNT}/
				${PIPE_CMD} ${i/:*/} -C ${KPATCH_DIR}/${STRICT_COUNT}/ 1>/dev/null
			else
				${PIPE_CMD} ${i/:*/} -C ${KPATCH_DIR} 1>/dev/null
			fi

			if [ $? == 0 ]
			then
				einfo "${i/*\//} unpacked"
				[ -n "$(echo ${i} | grep ':')" ] && echo ">>> Strict patch levels not currently supported for tarballed patchsets"
			else
				eerror "Failed to unpack ${i/:*/}"
				die "unable to unpack patch tarball"
			fi
		else
			extention=${i/*./}
			extention=${extention/:*/}
			PIPE_CMD=""
			case ${extention} in
				    bz2) PIPE_CMD="bzip2 -dc";;
				  patch) PIPE_CMD="cat";;
				   diff) PIPE_CMD="cat";;
				 gz|Z|z) PIPE_CMD="gzip -dc";;
				ZIP|zip) PIPE_CMD="unzip -p";;
				      *) UNIPATCH_DROP="${UNIPATCH_DROP} ${i/:*/}";;
			esac

			PATCH_LEVEL=${i/*([^:])?(:)}
			i=${i/:*/}
			x=${i/*\//}
			x=${x/\.${extention}/}
	
			if [ -n "${PIPE_CMD}" ]
			then
				if [ ! -r "${i}" ]
				then
					echo
					eerror "FATAL: unable to locate:"
					eerror "${i}"
					eerror "for read-only. The file either has incorrect permissions"
					eerror "or does not exist."
					die Unable to locate ${i}
				fi
			
				if [ -n "${UNIPATCH_STRICTORDER}" ]
				then
					STRICT_COUNT=$((${STRICT_COUNT} + 1))
					mkdir -p ${KPATCH_DIR}/${STRICT_COUNT}/
					$(${PIPE_CMD} ${i} > ${KPATCH_DIR}/${STRICT_COUNT}/${x}.patch${PATCH_LEVEL})
				else
					$(${PIPE_CMD} ${i} > ${KPATCH_DIR}/${x}.patch${PATCH_LEVEL})
				fi
			fi
		fi
	done

	#populate KPATCH_DIRS so we know where to look to remove the excludes
	x=${KPATCH_DIR}
	KPATCH_DIR=""
	LC_ALL="C"
	for i in $(find ${x} -type d | sort -n)
	do
		KPATCH_DIR="${KPATCH_DIR} ${i}"
	done

	#so now lets get rid of the patchno's we want to exclude
	UNIPATCH_DROP="${UNIPATCH_EXCLUDE} ${UNIPATCH_DROP}"
	for i in ${UNIPATCH_DROP}
	do
		ebegin "Excluding Patch #${i}"
		for x in ${KPATCH_DIR}
		do
			rm -f ${x}/${i}* 2>/dev/null
		done
		eend $?
	done

	# and now, finally, we patch it :)
	for x in ${KPATCH_DIR}
	do
		for i in $(find ${x} -maxdepth 1 -iname "*.patch*" -or -iname "*.diff*" | sort -n)
		do
			STDERR_T="${T}/${i/*\//}"
			STDERR_T="${STDERR_T/.patch*/.err}"

			[ -z ${i/*.patch*/} ] && PATCH_DEPTH=${i/*.patch/} 
			[ -z ${i/*.diff*/} ]  && PATCH_DEPTH=${i/*.diff/} 

			if [ -z "${PATCH_DEPTH}" ]; then
				PATCH_DEPTH=0
			fi

			ebegin "Applying ${i/*\//} (-p${PATCH_DEPTH}+)"
			while [ ${PATCH_DEPTH} -lt 5 ]
			do
				echo "Attempting Dry-run:" >> ${STDERR_T}
				echo "cmd: patch -p${PATCH_DEPTH} --dry-run -f < ${i}" >> ${STDERR_T}
				echo "=======================================================" >> ${STDERR_T}
				if [ $(patch -p${PATCH_DEPTH} --dry-run -f < ${i} >> ${STDERR_T}) $? -eq 0 ]
				then
					echo "Attempting patch:" > ${STDERR_T}
					echo "cmd: patch -p${PATCH_DEPTH} -f < ${i}" >> ${STDERR_T}
					echo "=======================================================" >> ${STDERR_T}
					if [ $(patch -p${PATCH_DEPTH} -f < ${i} >> ${STDERR_T}) "$?" -eq 0 ]
					then
						eend 0
						rm ${STDERR_T}
						break
					else
						eend 1
						eerror "Failed to apply patch ${i/*\//}"
						eerror "Please attach ${STDERR_T} to any bug you may post."
						die "Failed to apply ${i/*\//}"
					fi
				else
					PATCH_DEPTH=$((${PATCH_DEPTH} + 1))
				fi
			done
			if [ ${PATCH_DEPTH} -eq 5 ]
			then
				eend 1
				eerror "Please attach ${STDERR_T} to any bug you may post."
				die "Unable to dry-run patch."
			fi
		done
	done

	# clean up  KPATCH_DIR's - fixes bug #53610
	for x in ${KPATCH_DIR}
	do
		rm -Rf ${x}
	done
	unset LC_ALL
}

# custom functions
#==============================================================
detect_version() {
	# this function will detect and set
	# - OKV: Original Kernel Version (2.6.0/2.6.0-test11)
	# - KV: Kernel Version (2.6.0-gentoo/2.6.0-test11-gentoo-r1)
	# - EXTRAVERSION: The additional version appended to OKV (-gentoo/-gentoo-r1)
	
	if [ -n "${KV_FULL}" ] ;
	then
		# we will set this for backwards compatibility.
		KV=${KV_FULL}
		
		# we know KV_FULL so lets stop here. but not without resetting S
		S=${WORKDIR}/linux-${KV_FULL}
		return
	fi
	
	OKV=${PV/_beta/-test}
	OKV=${OKV/_rc/-rc}
	OKV=${OKV/_pre*/}
	OKV=${OKV/-r*/}
	
	KV_MAJOR=$(echo ${OKV} | cut -d. -f1)
	KV_MINOR=$(echo ${OKV} | cut -d. -f2)
	KV_PATCH=$(echo ${OKV} | cut -d. -f3-)
	KV_PATCH=${KV_PATCH/[-_]*/}	
	
	KERNEL_URI="mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/linux-${OKV}.tar.bz2"
	
	RELEASE=${PV/${OKV}/}
	RELEASE=${RELEASE/_beta/}
	RELEASE=${RELEASE/_rc/-rc}
	if [ $(kernel_is_2_4) $? == 0 ]
	then
		RELEASE=${RELEASE/_pre/-pre}
	else
	RELEASE=${RELEASE/_pre/-bk}
	fi
	RELEASETYPE=${RELEASE//[0-9]/}
	EXTRAVERSION="${RELEASE}"
	
	if [ -n "${K_PREPATCHED}" ]
	then
		EXTRAVERSION="${EXTRAVERSION}-${PN/-*/}${PR/r/}"
	else
		[ -z "${K_NOUSENAME}" ] && EXTRAVERSION="${EXTRAVERSION}-${PN/-*/}"
		[ "${PR}" != "r0" ] 	&& EXTRAVERSION="${EXTRAVERSION}-${PR}"
	fi
	
	KV_FULL=${OKV}${EXTRAVERSION}
	
	# -rcXX-bkXX pulls are *IMPOSSIBLE* to support within the portage naming convention
	# these cannot be supported, but the code here can handle it up until this point
	# and theoretically thereafter.
	
	if [ "${RELEASETYPE}" == "-rc" -o "${RELEASETYPE}" == "-pre" ]
	then
		OKV="${KV_MAJOR}.${KV_MINOR}.$([ $((${KV_PATCH} - 1)) -lt 0 ] && echo ${KV_PATCH} || echo $((${KV_PATCH} - 1)))"
		KERNEL_URI="mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/testing/patch-${PV//_/-}.bz2
			    mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/linux-${OKV}.tar.bz2"
		UNIPATCH_LIST_DEFAULT="${DISTDIR}/patch-${PV//_/-}.bz2"
		KV_FULL=${PV/[-_]*/}${EXTRAVERSION}
	fi
	
	if [ "${RELEASETYPE}" == "-bk" ]
	then
		OKV="${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}"
		KERNEL_URI="mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/snapshots/patch-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}${RELEASE}.bz2
			    mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/linux-${OKV}.tar.bz2"
		UNIPATCH_LIST_DEFAULT="${DISTDIR}/patch-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}${RELEASE}.bz2"
		KV_FULL=${PV/[-_]*/}${EXTRAVERSION}
	fi
	
	if [ "${RELEASETYPE}" == "-rc-bk" ]
	then
		OKV="${KV_MAJOR}.${KV_MINOR}.$((${KV_PATCH} - 1))-${RELEASE/-bk*}"
		EXTRAVERSION="$([ -n "${RELEASE}" ] && echo ${RELEASE/*-bk/-bk})$([ -n "${K_USENAME}" ] && echo -${PN/-*/})$([ ! "${PR}" == "r0" ] && echo -${PR})"
		
		KERNEL_URI="mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/snapshots/patch-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}${RELEASE}.bz2
			    mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/linux-${OKV}.tar.bz2"
		UNIPATCH_LIST_DEFAULT="${DISTDIR}/patch-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}${RELEASE}.bz2"
		KV_FULL=${PV/[-_]*/}${EXTRAVERSION}
	fi
	
	S=${WORKDIR}/linux-${KV_FULL}
	# we will set this for backwards compatibility.
	KV=${KV_FULL}
}

detect_arch() {
	# This function sets ARCH_URI and ARCH_PATCH
	# with the neccessary info for the arch sepecific compatibility
	# patchsets.
	
	local ALL_ARCH
	local LOOP_ARCH
	local COMPAT_URI
	local i

	# COMPAT_URI is the contents of ${ARCH}_URI
	# ARCH_URI is the URI for all the ${ARCH}_URI patches
	# ARCH_PATCH is ARCH_URI broken into files for UNIPATCH

	ARCH_URI=""
	ARCH_PATCH=""
	ALL_ARCH="X86 PPC PPC64 SPARC MIPS ALPHA ARM HPPA AMD64 IA64 X86OBSD S390"

	for LOOP_ARCH in ${ALL_ARCH}
	do
		COMPAT_URI="${LOOP_ARCH}_URI"
		COMPAT_URI="${!COMPAT_URI}"
		
		[ -n "${COMPAT_URI}" ] && \
			ARCH_URI="${ARCH_URI} $(echo ${LOOP_ARCH} | tr '[:upper:]' '[:lower:]')? ( ${COMPAT_URI} )"
		
		if [ "${LOOP_ARCH}" == "$(echo ${ARCH} | tr '[:lower:]' '[:upper:]')" ]
		then
			for i in ${COMPAT_URI}
			do
				ARCH_PATCH="${ARCH_PATCH} ${DISTDIR}/${i/*\//}"
			done
		fi
	done
}


# common functions
#==============================================================
kernel-2_src_unpack() {
	universal_unpack
	
	[ -n "${UNIPATCH_LIST}" -o -n "${UNIPATCH_LIST_DEFAULT}" ] && \
		unipatch "${UNIPATCH_LIST_DEFAULT} ${UNIPATCH_LIST}"
		
	[ -z "${K_NOSETEXTRAVERSION}" ] && \
		unpack_set_extraversion

	kernel_is 2 4 && unpack_2_4
}

kernel-2_src_compile() {
	[ "${ETYPE}" == "headers" ] && compile_headers
	[ "${ETYPE}" == "sources" ] && \
		use doc && ! use arm && ! use s390 && compile_manpages
}

kernel-2_pkg_preinst() {
	[ "${ETYPE}" == "headers" ] && preinst_headers
}

kernel-2_src_install() {
	install_universal
	[ "${ETYPE}" == "headers" ] && install_headers
	[ "${ETYPE}" == "sources" ] && install_sources
}

kernel-2_pkg_postinst() {
	[ "${ETYPE}" == "headers" ] && postinst_headers
	[ "${ETYPE}" == "sources" ] && postinst_sources
}

kernel-2_pkg_setup() {
	[ "${ETYPE}" == "headers" ] && setup_headers

	# This is to fix some weird portage bug? in stable versions of portage.
	[ "${ETYPE}" == "sources" ] && echo ">>> Preparing to unpack ..."
}


