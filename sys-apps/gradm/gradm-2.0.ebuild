# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gradm/gradm-2.0.ebuild,v 1.7 2005/01/08 21:26:59 solar Exp $

inherit flag-o-matic gcc

#MY_PV=2.0-${PV/*_/}

MAINTAINER="solar@gentoo.org"
DESCRIPTION="Administrative interface for grsecuritys2 access control lists"
HOMEPAGE="http://www.grsecurity.net/"
SRC_URI="http://www.grsecurity.net/gradm-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~arm ~amd64" ; # ~alpha"
IUSE=""

DEPEND="virtual/libc
	sys-devel/bison
	sys-devel/flex
	sys-apps/chpax"

S="${WORKDIR}/${PN}2"

src_unpack() {
	unpack ${A}
	cd ${S}

	# (Jan 03 2004) - <solar@gentoo>
	# static linking required for proper operation of gradm        
	# however ssp is known to break static linking when it's enabled
	# in >=gcc-3.3.1 && <=gcc-3.3.2-r5 . So we strip ssp if needed.         
	gmicro=$(gcc-micro-version)
	if [ "$(gcc-version)" == "3.3" -a -n "${gmicro}" -a ${gmicro} -le 2 ]; then
		# extract out gentoo revision                
		gentoo_gcc_r=$($(gcc-getCC) -v 2>&1 | tail -n 1 | awk '{print $7}')
		gentoo_gcc_r=${gentoo_gcc_r/,/}
		gentoo_gcc_r=${gentoo_gcc_r/-/ }
		gentoo_gcc_r=${gentoo_gcc_r:7}
		[ -n "${gentoo_gcc_r}" -a ${gentoo_gcc_r} -le 5 ] && \
			filter-flags -fstack-protector -fstack-protector-all
	fi

	ebegin "Patching Makefile to use gentoo CFLAGS"
	sed -i -e "s|-O2|${CFLAGS}|" Makefile
	eend $?

}

src_compile() {
	cd ${S}
	emake CC="$(gcc-getCC)" || die "compile problem"
}

src_install() {
	cd ${S}
	# Were not ready for init.d,script functions yet.
		#exeinto /etc/init.d
		#newexe ${FILESDIR}/grsecurity2.rc grsecurity2
		#insinto /etc/conf.d
		#doins ${FILESDIR}/grsecurity2

	mkdir -p -m 700 ${D}/etc/grsec
	doman gradm.8
	dodoc acl

	into /
	dosbin grlearn gradm || die

	# Normal users can authenticate to special roles now and thus 
	# need execution permission on gradm2. We remove group,other readable bits 
	# to help ensure that our gradm2 binary is as protected from misbehaving users.
	fperms 711 ${D}/sbin/gradm
}

pkg_postinst() {
	if [ ! -e /dev/grsec ] ; then
		einfo "Making character device for grsec2 learning mode"
		mkdir -p -m 755 /dev/
		mknod -m 0622 /dev/grsec c 1 10 || die "Cant mknod for grsec learning device"
	fi
}
