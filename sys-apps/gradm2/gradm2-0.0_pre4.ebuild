# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gradm2/gradm2-0.0_pre4.ebuild,v 1.2 2003/06/13 06:55:26 solar Exp $

MY_PV=2.0-pre4

MAINTAINER="solar@gentoo.org"
DESCRIPTION="Administrative interface for grsecuritys2 access control lists"
SRC_URI="http://www.grsecurity.net/gradm-${MY_PV}.tar.gz"
HOMEPAGE="http://www.grsecurity.net/"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"
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
	mv Makefile{,.orig}
	ebegin "Patching Makefile to use gentoo CFLAGS"
	sed -e "s|-O2|${CFLAGS}|" Makefile.orig > Makefile
	eend $?
	ebegin "Patching manpage"
	sed -e "s:gradm:gradm2:" -e "s:GRADM:GRADM2:" < gradm.8 > gradm2.8
	eend $?
	for f in Makefile acl gradm_defs.h grlearn.c; do
		[ -f ${f} ] && {
			ebegin "Patching ${f} to use /etc/grsec2"
			sed -e "s:/etc/grsec:/etc/grsec2:" \
			< ${f} > ${f}~ && cp ${f}~ ${f}
			eend $?
		}
	done
	# rm *~
}

src_compile() {
	cd ${S}
	emake CC="${CC}" || die "compile problem"
}

src_install() {
	cd ${S}
	mkdir -p ${D}/etc/grsec2
	doman gradm2.8
	dodoc acl
	# Were not ready for init.d,script functions yet.
		#exeinto /etc/init.d
		#newexe ${FILESDIR}/grsecurity.rc grsecurity
		#insinto /etc/conf.d
		#doins ${FILESDIR}/grsecurity
	into /
	mv gradm{,2}
	dosbin gradm2
	dosbin grlearn

	# Normal users can authenticate to special roles now and thus 
	# need execution permission on gradm2. We remove group,other readable bits 
	# to help ensure that our gradm2 binary is as protected from misbehaving users.
	fperms 711 ${D}/sbin/gradm2
}

pkg_setup() {
	if [ -e /usr/src/linux/grsecurity ]; then
		[ ! -e /usr/src/linux/grsecurity/gracl_learn.c ] && {
			ewarn "gradm2 was designed to be used with grsecurity2 but it looks like your using grsecurity1"
			ewarn "we hope you know what your doing"
			einfo "(hint try emerge sys-apps/gradm) If you need support for grsecurity 1.x"
			echo
		}
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

# grep "extern int grsec_" /usr/src/linux/include/linux/grinternal.h | sed s/'extern int grsec_*'/'# '/g | sed s:';':: | sort
