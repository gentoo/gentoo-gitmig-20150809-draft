# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gradm2/gradm2-0.0_rc3.ebuild,v 1.2 2004/01/03 23:06:05 solar Exp $

inherit flag-o-matic gcc

MY_PV=2.0-${PV/*_/}

MAINTAINER="solar@gentoo.org"
DESCRIPTION="Administrative interface for grsecuritys2 access control lists"
SRC_URI="http://www.grsecurity.net/gradm-${MY_PV}.tar.gz"
HOMEPAGE="http://www.grsecurity.net/"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc ~alpha"
SLOT="0"

IUSE=""
DEPEND="virtual/glibc
	sys-devel/bison
	sys-devel/flex
	sys-apps/chpax"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A} || die "Cant unpack ${A}"
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

	ebegin "Patching manpage"
	sed -e "s:gradm:gradm2:" -e "s:GRADM:GRADM2:" < gradm.8 > gradm2.8
	eend $?

	for f in Makefile acl gradm_defs.h grlearn.c; do
		[ -f ${f} ] && {
			ebegin "Patching ${f} to use /etc/grsec2"
			sed -i -e "s:/etc/grsec:/etc/grsec2:" ${f}
			eend $?
		}
	done
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

	mkdir -p -m 755 ${D}/dev/
	mknod -m 0622 ${D}/dev/grsec c 1 10 || die "Cant mknod for grsec learning device"
	mkdir -p -m 700 ${D}/etc/grsec2
	doman gradm2.8
	dodoc acl

	into /
	mv gradm{,2}
	dosbin grlearn
	dosbin gradm2

	# Normal users can authenticate to special roles now and thus 
	# need execution permission on gradm2. We remove group,other readable bits 
	# to help ensure that our gradm2 binary is as protected from misbehaving users.
	fperms 711 ${D}/sbin/gradm2
}

pkg_setup() {
	if [ -e /usr/src/linux/grsecurity ]; then
		if [ ! -e /usr/src/linux/grsecurity/gracl_learn.c ]; then
			ewarn "gradm2 was designed to be used with grsecurity2 but it looks like your using grsecurity1"
			ewarn "we hope you know what your doing"
			einfo "(hint try emerge sys-apps/gradm) If you need support for grsecurity 1.x"
			echo
		fi
	else
		ewarn "Your going to need to a grsecurity2 enabled kernel to take advantage of the tool"
	fi
}

pkg_postinst() {
	[ ! -d /proc/sys/kernel/grsecurity ] && ewarn "This kernel does not seem to be a grsec enabled kernel (or we are in chroot install?)"
	if [ ! -f /usr/src/linux/grsecurity/gracl_learn.c ]; then
		ewarn "It does not seem that your are running a grsec2 enabled kernel"
		einfo "(hint >=hardened-sources-2.4.20-r3) was the first kernel to include support"
	else
		einfo "Everything looks good and you seem to be using a grsec2 enabled kernel"
	fi
	einfo "Bugs can be reported to <${MAINTAINER}> using http://bugs.gentoo.org"
}
