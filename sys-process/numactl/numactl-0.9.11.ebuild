# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/numactl/numactl-0.9.11.ebuild,v 1.2 2008/01/14 02:21:08 robbat2 Exp $

inherit base eutils toolchain-funcs

DESCRIPTION="Utilities and libraries for NUMA systems."
HOMEPAGE="ftp://ftp.suse.com/pub/people/ak/numa/"
SRC_URI="ftp://ftp.suse.com/pub/people/ak/numa/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""
RDEPEND="virtual/libc
		dev-lang/perl"
DEPEND="${RDEPEND}
		sys-apps/groff"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${PN}-0.9.11-make-jobs.patch
}

src_compile() {
	emake all html \
		CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
		|| die "emake failed"
}

src_install() {
	# do this manually, as the Makefile doesn't do a good job
	dobin numactl migratepages numastat
	dolib.so libnuma.so.1
	insinto /usr/include
	doins numa.h numaif.h
	doman migratepages.8 numa.3 numa_maps.5 numactl.8 numastat.8
	dodoc README TODO CHANGES DESIGN
	dodoc numademo.c memhog.c
	dohtml html/*html
	cd "${D}"/usr/share/man/man3
	# this list stolen from the Makefile
	local MANLINKS="all_nodes alloc alloc_interleaved alloc_interleaved_subset
	alloc_local alloc_onnode available bind error exit_on_error free
	get_interleave_mask get_interleave_node get_membind get_run_node_mask
	interleave_memory max_node no_nodes node_size node_to_cpus police_memory
	preferred run_on_node run_on_node_mask set_bind_policy  set_interleave_mask
	set_localalloc set_membind set_preferred set_strict setlocal_memory
	tonode_memory tonodemask_memory distance"
	for i in ${MANLINKS}; do
		ln -sf numa.3 numa_${i}.3
	done
}

src_test() {
	einfo "The only generically safe test is regress2."
	einfo "The other test cases require 2 NUMA nodes."
	cd "${S}"/test
	./regress2 || die "regress2 failed!"
}
