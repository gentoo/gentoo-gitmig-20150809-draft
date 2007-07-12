# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/wanpipe/wanpipe-2.3.2_p4.ebuild,v 1.4 2007/07/12 02:52:15 mr_bones_ Exp $

inherit eutils toolchain-funcs linux-mod

DESCRIPTION="Driver for Sangoma WAN cards"
HOMEPAGE="http://www.sangoma.com/"
SRC_URI="ftp://ftp.sangoma.com/linux/current_wanpipe/${P//_p/-}.tgz"

LICENSE="WANPIPE"
SLOT="0"
KEYWORDS="~x86"

IUSE="adsl"

RDEPEND="sys-libs/ncurses
	 >=net-misc/zaptel-1.2.0_beta1"

DEPEND="sys-devel/flex
	${RDEPEND}"

S=${WORKDIR}/${PN}
S_BUILD=${WORKDIR}/build-tmp

# Test log:
#
# Compile OK: linux-2.6.12.2
#			(zaptel-1.0.8 + /usr/include/zaptel hack)
#	      linux-2.4.29-nd1
#			(zaptel-1.0.7-r1 + /usr/include/zaptel hack)
#             linux-2.6.11.12-grsec
#			(zaptel-1.2.0_pre20050817 + /usr/include/zaptel)
#             linux-2.6.12
#			(zaptel-1.2.0_beta1)

pkg_setup() {
	linux-mod_pkg_setup

	local n

	ewarn "****************************** WARNING! ******************************"
	ewarn "*                                                                    *"
	ewarn "* ALPHA QUALITY EBUILD                                               *"
	ewarn "*                                                                    *"
	ewarn "* Sangoma drivers built with this ebuild are _completely_ untested!  *"
	ewarn "* (Due to lack of hardware and a T1/E1 line)                         *"
	ewarn "*                                                                    *"
	ewarn "* There is no init script to setup the card(s) on startup!           *"
	ewarn "*                                                                    *"
	ewarn "* You have been warned!                                              *"
	ewarn "*    - stkn                                                          *"
	ewarn "****************************** WARNING! ******************************"
	echo
	ebeep

	n=10
	while [[ $n -gt 0 ]]; do
		echo -en "  Waiting $n seconds...\r"
		sleep 1
		(( n-- ))
	done
}

src_unpack() {
	local binobj

	unpack ${A}

	# Instead of patching stuff in /usr/src/linux, we'll
	# copy all needed files to ${S_BUILD} and build everything
	# there

	# let's go...
	cd ${S}

	mkdir -p ${S_BUILD}/{src,include}
	mkdir -p ${S_BUILD}/src/{mod,tmp}
	ln -s ${S_BUILD}/src ${S_BUILD}/src/modinfo
	ln -s ${S_BUILD}/src ${S_BUILD}/src/common

	cp -dPR /usr/src/linux/drivers/net/wan/*.{c,h} ${S_BUILD}/src
	cp -dPR /usr/src/linux/include/linux           ${S_BUILD}/include

	cp ${S}/patches/kdrivers/src/wanrouter/*.c     ${S_BUILD}/src
	cp ${S}/patches/kdrivers/src/wan_aften/*.c     ${S_BUILD}/src
	cp ${S}/patches/kdrivers/src/net/*.c           ${S_BUILD}/src

	cp ${S}/patches/kdrivers/include/*.h           ${S_BUILD}/include/linux

	sed -i  -e "s:\(-I/usr/src/linux/include \):-I${S_BUILD}/include \1:g" \
		-e "s:-I/usr/src/zaptel:-I/usr/include/zaptel:g" \
		${S}/Makefile

	#
	# step 2: select the right binary modules and copy them
	#
	if [[ "$(gcc-major-version)" == "2" ]]; then
		binobj="gcc2"
	else
		binobj="gcc3"
	fi

	binobj="${binobj}.$(uname -m)"

	linux_chkconfig_present REGPARM \
		&& binobj="${binobj}.regparm" \

	cp patches/kdrivers/src/net/wanpipe_adsl.${binobj}.o ${S_BUILD}/src/wanpipe_adsl.o
	cp patches/kdrivers/src/net/wanpipe_atm.${binobj}.o  ${S_BUILD}/src/wanpipe_atm.o
	# fix the makefile...
	sed -i  -e "s:../adsl/wanpipe_adsl.o:common/wanpipe_adsl.o:g" \
		-e "s:../atm/wanpipe_atm.o:common/wanpipe_atm.o:g" \
		${S}/Makefile

	# these are needed too, wanpipe won't load otherwise
	sed -i  -e "s:^\(WANPIPE_FILE_LIST.*\):\1 sdla_edu.o sdla_bitstrm.o sdla_adccp.o sdla_sdlc.o sdla_mp_fr.o sdla_pos.o:" \
		${S}/Makefile

	# fix Makefile for amd64
	use amd64 && \
		sed -i  -e "s:-march=\$(ARCH):-march=k8 -mcmodel=kernel:" \
			-e "s:\(-mpreferred-stack-boundary\)=2:\1=4:" \
			-e "s:^\(LD_ELF=\).*:\1-m elf_x86_64:" \
			${S}/Makefile

	# apply patch for gcc3.4 (todo: change path in patch to ${S}/...)
	cd ${WORKDIR}
	epatch ${FILESDIR}/${P}-gcc34.diff
}

src_compile() {
	#
	# well for the drivers, all that's left to do is:
	#
	cd ${S_BUILD}/src
	make -f ${S}/Makefile || die "Error building drivers!"

	#
	# Build utilities
	#
	einfo "Building utils..."
	cd ${S}/util
	make \
		SYSINC=${S_BUILD}/include \
		PROTOCOL_DEFS=$(use adsl && echo "-DCONFIG_PRODUCT_WANPIPE_ADSL")

	#
	# Build WanCfg tool
	#
	einfo "Building WanCfg tool..."
	make -C wancfg all \
		SYSINC=${S_BUILD}/include

	#
	# Build misc utilities
	#
	einfo "Building misc utilities..."
	make -C misc clean all \
		SYSINC=${S_BUILD}/include

	#
	# Build API (for development)
	#
#	if ! use minimal; then
#		einfo "Building development API..."
#		cd ${S}/api
#		make \
#			SYSINC=${S_BUILD}/include
#	else
#		einfo "Skipping API build..."
#	fi
}

src_install() {
	#
	# install kernel modules
	#
	insinto /lib/modules/${KV_FULL}/extra
	doins ${S_BUILD}/src/mod/*.${KV_OBJ}

	#
	# install firmware
	#
	insinto /lib/firmware
	doins firmware/*.sfm

	#
	# install tools
	#
	einfo "Installing utils..."
	cd ${S}/util
	make install \
		WAN_VIRTUAL=${D}

	einfo "Installing misc utilities..."
	make -C misc install \
		WAN_VIRTUAL=${D}
	cd ${S}

	#
	# install config + scripts
	#
#	newconfd ${FILESDIR}/wanpipe.confd wanpipe

	#
	# finally install docs
	#
	dodoc doc/README* doc/ANNOUNCE doc/COPYING doc/LICENSE
	dodoc doc/*.txt

	insinto /usr/share/doc/${PF}
	doins doc/*.pdf doc/*.sfm
}
