# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/tcp-wrappers/tcp-wrappers-7.6-r8.ebuild,v 1.9 2004/03/29 05:15:56 randy Exp $

inherit eutils

MY_P="${P//-/_}"

S="${WORKDIR}/${MY_P}"
DESCRIPTION="TCP Wrappers"
SRC_URI="ftp://ftp.porcupine.org/pub/security/${MY_P}.tar.gz
	mirror://gentoo/${P}-r7-patches.tar.bz2"
HOMEPAGE="ftp://ftp.porcupine.org/pub/security/index.html"
IUSE="ipv6 static"
SLOT="0"
LICENSE="freedist"
KEYWORDS="x86 ~amd64 ~ppc sparc alpha mips hppa ia64 ~ppc64 s390"

DEPEND="virtual/glibc
	>=sys-apps/sed-4"
RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A} ; cd ${S}

	chmod ug+w Makefile
	sed -i -e "s:-O:${CFLAGS}:" \
		-e "s:AUX_OBJ=.*:AUX_OBJ= \\\:" \
	Makefile

	PATCHDIR=${WORKDIR}/${PV}-patches

	epatch ${PATCHDIR}/${P}-makefile.patch.bz2

	epatch ${PATCHDIR}/generic

	use static || epatch ${PATCHDIR}/${P}-shared.patch.bz2
	use ipv6 && epatch ${PATCHDIR}/${P}-ipv6-1.14.diff.bz2
}

src_compile() {
	local myconf=

	use static || myconf="${myconf} -DHAVE_WEAKSYMS"
	use ipv6 && myconf="${myconf} -DINET6=1 -Dss_family=__ss_family -Dss_len=__ss_len"

	make ${MAKEOPTS} \
		REAL_DAEMON_DIR=/usr/sbin \
		GENTOO_OPT="${myconf}" \
		MAJOR=0 MINOR=${PV:0:1} REL=${PV:2:3} \
		config-check || die

	make ${MAKEOPTS} \
		REAL_DAEMON_DIR=/usr/sbin \
		GENTOO_OPT="${myconf}" \
		MAJOR=0 MINOR=${PV:0:1} REL=${PV:2:3} \
		linux || die
}

src_install() {
	dosbin tcpd tcpdchk tcpdmatch safe_finger try-from

	doman *.[358]
	dosym hosts_access.5.gz /usr/share/man/man5/hosts.allow.5.gz
	dosym hosts_access.5.gz /usr/share/man/man5/hosts.deny.5.gz

	insinto /usr/include
	doins tcpd.h

	into /usr
	dolib.a libwrap.a

	if [ -z `use static` ]; then
		into /
		newlib.so libwrap.so libwrap.so.0.${PV}
		dosym /lib/libwrap.so.0.${PV} /lib/libwrap.so.0
		dosym /lib/libwrap.so.0 /lib/libwrap.so
		# bug #4411
		gen_usr_ldscript libwrap.so || die "gen_usr_ldscript failed"
	fi

	dodoc BLURB CHANGES DISCLAIMER README* ${FILESDIR}/hosts.allow.example
}
