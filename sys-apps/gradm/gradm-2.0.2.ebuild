# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gradm/gradm-2.0.2.ebuild,v 1.1 2004/11/30 06:28:49 solar Exp $

inherit flag-o-matic gcc eutils

MAINTAINER="solar@gentoo.org"
DESCRIPTION="Administrative interface for grsecuritys2 access control lists"
HOMEPAGE="http://www.grsecurity.net/"
SRC_URI="http://www.grsecurity.net/gradm-${PV}.tar.gz"
#SRC_URI="mirror://gentoo/gradm-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~arm ~amd64" ; # ~alpha"
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
	[ "$PV" == "2.0.1" ] && epatch ${FILESDIR}/${PN}-${PV}-install.patch
}

src_compile() {
	cd ${S}
	emake CC="$(gcc-getCC)" || die "compile problem"
	return 0
}

src_install() {
	cd ${S}
	einstall DESTDIR=${D}

	# Normal users can authenticate to special roles now and thus 
	# need execution permission on gradm2. We remove group,other readable bits 
	# to help ensure that our gradm2 binary is as protected from misbehaving users.
	fperms 711 /sbin/gradm

	return 0
}

pkg_postinst() {
	if [ ! -e /dev/grsec ] ; then
		einfo "Making character device for grsec2 learning mode"
		mkdir -p -m 755 /dev/
		mknod -m 0622 /dev/grsec c 1 12 || die "Cant mknod for grsec learning device"
	fi
	ewarn "Be sure to set a password with 'gradm -P' before enabling learning mode"
}
