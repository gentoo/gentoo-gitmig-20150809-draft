# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gradm/gradm-1.9.14.ebuild,v 1.5 2005/01/08 21:26:59 solar Exp $

inherit gcc flag-o-matic eutils

DESCRIPTION="Administrative interface for grsecurity ${PV} access control lists"
HOMEPAGE="http://www.grsecurity.net/"
SRC_URI="http://www.grsecurity.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~hppa ~amd64"
IUSE=""

DEPEND="virtual/libc
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
