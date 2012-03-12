# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/maradns/maradns-2.0.06.ebuild,v 1.1 2012/03/12 12:24:50 kumba Exp $

EAPI="4"
inherit eutils toolchain-funcs flag-o-matic

DEADWOOD_VER="3.2.02"

DESCRIPTION="A security-aware DNS server"
HOMEPAGE="http://www.maradns.org/"
SRC_URI="http://www.maradns.org/download/${PV%.*}/${PV}/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~mips"
IUSE="authonly ipv6"

DEPEND=""
RDEPEND=""

src_prepare() {
	local myflags

	# Apply some minor patches from Debian.
	epatch "${FILESDIR}"/${P}-askmara-tcp.patch
	epatch "${FILESDIR}"/${P}-duende-man.patch

	# In order for Deadwood to build correctly, it needs to know where
	# clock_getttime is at, and on Linux/glibc, this is in librt.
	# Hopefully, other systems won't have issues.
	use elibc_glibc && myflags="-lrt"

	# Honor system CFLAGS.
	# Need to append -lrt to build Deadwood properly.
	sed -i \
		-e "s:FLAGS=-O2:\$(M):g" \
		-e "s:-O2:\$(CFLAGS) \$(LDFLAGS) ${myflags}:" \
		-e "s:\$(CC):$(tc-getCC):g" \
		-e "s:make:\$(MAKE):g" \
		build/Makefile.linux || die
}

src_configure() {
	local myconf

	# Use duende-ng.c.
	cp  "${S}/tools/duende-ng.c" "${S}/tools/duende.c"

	use ipv6 && myconf="${myconf} --ipv6"
	./configure ${myconf} || die "Failed to configure ${PN}."
}

src_compile() {
	make ${MAKEOPTS} || die "Filed to compile ${PN}."

	# On linux/glibc, we forced -lrt into the build flags to make sure
	# that clock_getttime() was found in the correct library.  But to
	# catch this error on other platforms, we'll see if DwSys.o is
	# present, which indicates a successful build or not.
	[[ ! -f "${S}/deadwood-${DEADWOOD_VER}/src/DwSys.o" ]]	\
		&& die "Deadwood failed to build, possibly due to a "	\
		       "missing reference to clock_gettime.  Please "	\
		       "report this in a bug!"
}

src_install() {
	# Install the MaraDNS binaries.
	dosbin server/maradns
	dosbin tcp/zoneserver
	dobin tcp/getzone tcp/fetchzone
	dobin tools/askmara tools/askmara-tcp tools/duende
	dobin tools/bind2csv2.py tools/csv1tocsv2.pl

	# MaraDNS docs, manpages, misc.
	dodoc doc/en/{QuickStart,README,*.txt}
	dodoc doc/en/text/*.txt
	doman doc/en/man/*.[1-9]
	dodoc maradns.gpg.key
	dohtml doc/en/*.html
	dohtml -r doc/en/webpage
	dohtml -r doc/en/tutorial
	docinto examples
	dodoc doc/en/examples/example_*

	# Deadwood binary, docs, manpages, etc.
	if ! use authonly; then
		dosbin deadwood-${DEADWOOD_VER}/src/Deadwood
		doman deadwood-${DEADWOOD_VER}/doc/{Deadwood,Duende}.1
		docinto deadwood
		dodoc deadwood-${DEADWOOD_VER}/doc/{Deadwood,Duende,FAQ}.txt
		dohtml deadwood-${DEADWOOD_VER}/doc/{Deadwood,FAQ}.html
		docinto deadwood/internals
		dodoc deadwood-${DEADWOOD_VER}/doc/internals/*
		insinto /etc/maradns
		newins deadwood-${DEADWOOD_VER}/doc/dwood3rc-all dwood3rc_all.dist
	fi

	# Example configurations.
	insinto /etc/maradns
	newins doc/en/examples/example_full_mararc mararc_full.dist
	newins doc/en/examples/example_csv2 example_csv2.dist
	keepdir /etc/maradns/logger

	# Init scripts.
	newinitd "${FILESDIR}"/maradns2 maradns
	newinitd "${FILESDIR}"/zoneserver2 zoneserver
	if ! use authonly; then
		newinitd "${FILESDIR}"/deadwood deadwood
	fi
}

pkg_postinst() {
	enewgroup maradns 99
	enewuser duende 66 -1 -1 maradns
	enewuser maradns 99 -1 -1 maradns
}
