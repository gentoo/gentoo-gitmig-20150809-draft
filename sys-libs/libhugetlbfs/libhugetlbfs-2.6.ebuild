# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libhugetlbfs/libhugetlbfs-2.6.ebuild,v 1.1 2009/10/31 07:59:56 robbat2 Exp $

EAPI=2
inherit eutils multilib toolchain-funcs

DESCRIPTION="easy hugepage access"
HOMEPAGE="http://libhugetlbfs.ozlabs.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

DEPEND=""

# testsuite requires specific kernel options, and LOTS of free memory.
# with 16GiB of RAM available, I hit swap :-) - robbat2
RESTRICT=test

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.6-noexec-stack.patch
	sed -i \
		-e '/^PREFIX/s:/local::' \
		-e '1iBUILDTYPE = NATIVEONLY' \
		-e '1iV = 1' \
		-e "/^LIB\(32\)/s:=.*:= $(get_libdir):" \
		-e '/^CC\(32\|64\)/s:=.*:= $(CC):' \
		Makefile
	if [ "$(get_libdir)" == "lib64" ]; then
		sed -i \
			-e "/^LIB\(32\)/s:=.*:= lib32:" \
				Makefile
	fi
}

src_configure() {
	:
}

src_compile() {
	tc-export AR CC
	emake libs tools || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc HOWTO NEWS README
	rm "${D}"/usr/bin/oprofile*
}

src_test() {
	emake tests || die "Failed to build tests"
	hugeadm='obj/hugeadm'
	${hugeadm} --create-mounts
	PAGESIZES="$(${hugeadm} --page-sizes-all)"
	MIN_HUGEPAGE_RAM=$((64*1024*1024))
	ALLOCATED=''
	for p in ${PAGESIZES} ; do
		pagecount=$((${MIN_HUGEPAGE_RAM}/${p}))
		${hugeadm} \
		--pool-pages-min ${p}:+${pagecount} \
		--pool-pages-max ${p}:+${pagecount} \
		&& ALLOCATED="${ALLOCATED} ${p}:${pagecount}" \
		|| die "Failed to set pages"
	done
	cd "${S}"/tests
	TESTOPTS="-t func"
	case $ARCH in
		amd64|ppc64)
			TESTOPTS="${TESTOPTS} -b 64"
			;;
		x86)
			TESTOPTS="${TESTOPTS} -b 32"
			;;
	esac
	./run_tests.py ${TESTOPTS}
	# TODO: undo the allocation here.
	for p in ${ALLOCATED} ; do
		:
	done
}


