# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gradm/gradm-1.9.13.ebuild,v 1.2 2004/01/02 20:19:09 solar Exp $

inherit gcc flag-o-matic

DESCRIPTION="Administrative interface for grsecurity ${PV} access control lists"
SRC_URI="http://www.grsecurity.net/${P}.tar.gz"
HOMEPAGE="http://www.grsecurity.net/"

LICENSE="GPL-2"
KEYWORDS="x86 amd64 sparc ~ppc hppa"
SLOT="0"

IUSE=""
DEPEND="virtual/glibc
	sys-devel/bison
	sys-devel/flex
	sys-apps/chpax"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gradm_parse.c-1.9.x.patch

	# (Jan 2 2004) - <solar@gentoo>
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

	sed -i -e "s|-O2|${CFLAGS}|" Makefile
}

src_compile() {
	emake CC="$(gcc-getCC)" || die "compile problem"
}

src_install() {
	doman gradm.8
	dodoc acl
	exeinto /etc/init.d
	newexe ${FILESDIR}/grsecurity.rc grsecurity
	insinto /etc/conf.d
	doins ${FILESDIR}/grsecurity
	into /
	dosbin gradm
	fperms 700 /sbin/gradm
}
