# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/kernel.eclass,v 1.53 2004/12/03 19:20:52 vapier Exp $
#
# This eclass contains the common functions to be used by all lostlogic
# based kernel ebuilds
# with error handling contributions by gerk, and small fixes by zwelch
# small naming fix by kain
# moved set_arch_to_ functions to eutils -iggy (20041002)

inherit eutils

ECLASS=kernel
EXPORT_FUNCTIONS src_unpack src_compile src_install pkg_preinst pkg_postinst

export CTARGET="${CTARGET:-${CHOST}}"

HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/" 
LICENSE="GPL-2"
IUSE="build"

if [ "${ETYPE}" = "sources" ]
then
	#kbd is needed to solve the loadkeys fiasco; binutils version needed to avoid Athlon/PIII/SSE assembler bugs.
	DEPEND="!build? ( sys-apps/sed
			>=sys-devel/binutils-2.11.90.0.31 )
		app-admin/addpatches"
	RDEPEND="${DEPEND}
		 !build? ( >=sys-libs/ncurses-5.2
			dev-lang/perl
			virtual/modutils
			sys-devel/make )"
	PROVIDE="virtual/linux-sources"
elif [ "${ETYPE}" = "headers" ]
then
	PROVIDE="virtual/kernel virtual/os-headers"
else
	eerror "Unknown ETYPE=\"${ETYPE}\"!"
	die
fi

[ -z "$LINUX_HOSTCFLAGS" ] && LINUX_HOSTCFLAGS="-Wall -Wstrict-prototypes -Os -fomit-frame-pointer -I${S}/include"

KV_MAJOR=$(echo ${KV} | cut -d. -f1)
KV_MINOR=$(echo ${KV} | cut -d. -f2)
KV_PATCH=$(echo ${KV} | cut -d. -f3)

kernel_is_2_4() {
	if [ ${KV_MAJOR} -eq 2 -a ${KV_MINOR} -eq 4 ]
	then
		return 0
	else
		return 1
	fi
}

kernel_is_2_6() {
	if [ ${KV_MAJOR} -eq 2 -a ${KV_MINOR} -eq 5 -o ${KV_MINOR} -eq 6 ]
	then
		return 0
	else
		return 1
	fi
}

kernel_exclude() {
	for mask in ${KERNEL_EXCLUDE}
	do
		for patch in *${mask}*
		do
			einfo "Excluding: ${patch}"
			rm ${patch}
		done
	done
}

kernel_universal_unpack() {
	find . -iname "*~" -exec rm {} \; 2> /dev/null

	# Gentoo Linux uses /boot, so fix 'make install' to work properly
	# also fix the EXTRAVERSION
	cd ${S}
	mv Makefile Makefile.orig
	sed -e 's:#export\tINSTALL_PATH:export\tINSTALL_PATH:' \
		-e "s:^\(EXTRAVERSION =\).*:\1 ${EXTRAVERSION}:" \
		Makefile.orig >Makefile || die # test, remove me if Makefile ok
	rm Makefile.orig

	if [ -d "${S}/Documentation/DocBook" ]
	then
		cd ${S}/Documentation/DocBook
		sed -e "s:db2:docbook2:g" Makefile > Makefile.new \
			&& mv Makefile.new Makefile
		cd ${S}
	fi

	if kernel_is_2_4 || [ ${ETYPE} == "headers" ]
	then
		# this file is required for other things to build properly, 
		# so we autogenerate it
		set_arch_to_kernel
		make mrproper || die "make mrproper died"
		make include/linux/version.h || die "make include/linux/version.h failed"
		set_arch_to_portage
		echo ">>> version.h compiled successfully."
	fi
}

kernel_src_unpack() {
	kernel_exclude

	/usr/bin/addpatches . ${WORKDIR}/linux-${KV} || \
		die "Addpatches failed, bad KERNEL_EXCLUDE?"

	kernel_universal_unpack
}

kernel_src_compile() {
	if [ ${ETYPE} == "headers" ]
	then
		set_arch_to_kernel
		yes "" | make oldconfig
		set_arch_to_portage
		echo ">>> make oldconfig complete"
	fi
}

kernel_src_install() {
	#fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R root:root *
	chmod -R a+r-w+X,u+w *

	# Cross-compiling support
	[ "${CTARGET}" = "${CHOST}" ] \
		&& LINUX_INCDIR=/usr/include \
		|| LINUX_INCDIR=/usr/${CTARGET}/include
	export LINUX_INCDIR

	cd ${S}
	if [ "$ETYPE" = "sources" ]
	then
		dodir /usr/src
		echo ">>> Copying sources..."
		if [ -d "${WORKDIR}/${KV}/docs/" ]
		then
			for file in $(ls -1 ${WORKDIR}/${KV}/docs/)
			do
				echo "XX_${file}*" >> patches.txt
				cat ${WORKDIR}/${KV}/docs/${file} >> patches.txt
			done
		fi

		if [ ! -f patches.txt ]
		then
			# patches.txt is empty so lets use our ChangeLog
			[ -f ${FILESDIR}/../ChangeLog ] && echo "Please check out the changelog for this package to find out more" > patches.txt
		fi

		if [ -f patches.txt ]; then
			dodoc patches.txt
		fi
		mv ${WORKDIR}/linux* ${D}/usr/src
	else
		# linux-headers
		dodir ${LINUX_INCDIR}/linux
		cp -ax ${S}/include/linux/* ${D}/${LINUX_INCDIR}/linux
		rm -rf ${D}/${LINUX_INCDIR}/linux/modules
		dodir ${LINUX_INCDIR}/asm
		cp -ax ${S}/include/asm/* ${D}/${LINUX_INCDIR}/asm
	fi
}

kernel_pkg_preinst() {
	if [ "$ETYPE" = "headers" ] 
	then
		[ -L ${ROOT}usr/include/linux ] && rm ${ROOT}usr/include/linux
		[ -L ${ROOT}usr/include/asm ] && rm ${ROOT}usr/include/asm
		true
	fi
}

kernel_pkg_postinst() {
	[ "$ETYPE" = "headers" ] && return
	if [ ! -e ${ROOT}usr/src/linux ]
	then
		rm -f ${ROOT}usr/src/linux
		if use ppc
		then
			ln -sf ${PF} ${ROOT}/usr/src/linux
		else
			ln -sf linux-${KV} ${ROOT}/usr/src/linux
		fi
	fi

	echo
	einfo "After installing a new kernel of any version, it is important"
	einfo "that you have the appropriate /etc/modules.autoload.d/kernel-X.Y"
	einfo "created (X.Y is the first 2 parts of your new kernel version)"
	echo
	einfo "For example, this kernel will require:"
	einfo "/etc/modules.autoload.d/kernel-${KV_MAJOR}.${KV_MINOR}"
	echo
}
