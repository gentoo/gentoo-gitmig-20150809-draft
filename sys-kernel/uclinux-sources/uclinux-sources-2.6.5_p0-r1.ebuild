# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/uclinux-sources/uclinux-sources-2.6.5_p0-r1.ebuild,v 1.2 2004/05/30 23:53:42 pvdabeel Exp $

IUSE=""

ETYPE="sources"
inherit kernel eutils
OKV="`echo ${PV}|sed -e 's:^\([0-9]\+\.[0-9]\+\.[0-9]\+\).*:\1:'`"

EXTRAVERSION="uc${PV/*_p/}"
[ "${PR}" != "r0" ] && EXTRAVERSION="${EXTRAVERSION}-${PR}"
KV="${OKV}-${EXTRAVERSION}"

# Get the major & minor kernel version
MMV=`echo $PV | awk -F. '{print $1"."$2}'`

patch="diff"
base="uClinux"
if [ ${MMV} == "2.6" ]; then
	patch="patch"
	base="linux"
fi

MY_P=linux-${PV/_p/-uc}

S=${WORKDIR}/linux-${KV}
DESCRIPTION="uCLinux kernel patches for CPUs without MMUs"
SRC_URI="mirror://kernel/v${MMV}/linux-${OKV}.tar.bz2
	http://www.uclinux.org/pub/uClinux/uClinux-${MMV}.x/${MY_P/linux/${base}}.${patch}.gz"

HOMEPAGE="http://www.uclinux.org/"
KEYWORDS="~x86 -ppc"
SLOT="${KV}"

src_unpack() {
	unpack ${A}
	mv linux-${OKV} linux-${KV} || die

	cd linux-${KV}
	epatch ../${MY_P/linux/${base}}.${patch} || die "Failed to apply uClinux patch!"

	set MY_ARCH=${ARCH}
	unset ARCH
	rm ../${MY_P/linux/${base}}.${patch}
	epatch ${FILESDIR}/${P}.CAN-2004-0109.patch || die "Failed to patch CAN-2004-0109 vulnerability!"

	kernel_universal_unpack
	set ARCH=${MY_ARCH}
}
