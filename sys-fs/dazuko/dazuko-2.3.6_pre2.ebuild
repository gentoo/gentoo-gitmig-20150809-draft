# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/dazuko/dazuko-2.3.6_pre2.ebuild,v 1.1 2009/02/22 13:19:56 carlo Exp $

inherit linux-mod toolchain-funcs flag-o-matic

MY_P="${P/_/-}" # for -preN versions
S="${WORKDIR}/${MY_P}"

REDIRFS_P="redirfs-0.6"

DESCRIPTION="Linux kernel module and interface providing file access control"
HOMEPAGE="http://www.dazuko.org"
SRC_URI="http://dazuko.dnsalias.org/files/${MY_P}.tar.gz
	http://www.redirfs.org/packages/${REDIRFS_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2 BSD"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="kernel_linux? (	>=virtual/linux-sources-2.6.27 )
	~sys-fs/redirfs-0.6"
RDEPEND="${DEPEND}"

pkg_setup() {
	[ "${KERNEL}" = "linux" ] && linux-mod_pkg_setup
	# kernel settings
	if [ "${KERNEL}" = "linux" ] && kernel_is le 2 4; then
		BUILD_TARGETS="all"
	else
		EXTRA_CONFIG="--enable-redirfs --redirfsdir=${WORKDIR}/${REDIRFS_P}"
		BUILD_TARGETS="dummy_rule"
	fi
	MODULE_NAMES="dazuko(misc:)"

	ewarn "Please notice that Dazuko 2.x is not maintained any longer."
	ewarn "Work continues on DazukoFS. For more information see:"
	ewarn "http://lists.gnu.org/archive/html/dazuko-devel/2009-02/msg00001.html"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/dazuko-2.3.6-pre2_redirfs-0.6.patch"
}

src_compile() {
	if [ "${KERNEL}" = "FreeBSD" ]; then
		KERNEL_DIR=/usr/src/sys
		KBUILD_OUTPUT=/boot/modules
		MAKE=make
	fi
	./configure \
		--without-dep \
		--kernelsrcdir="${KERNEL_DIR}" \
		--kernelobjdir="${KBUILD_OUTPUT}" \
		${EXTRA_CONFIG} \
		|| die "configure failed"

	if [ "${KERNEL}" = "linux" ]; then
		convert_to_m Makefile
		linux-mod_src_compile
	else
		emake CC="$(tc-getCC)" LD="$(tc-getLD)" LDFLAGS="$(raw-ldflags)" || die
	fi

	emake -C library CC="$(tc-getCC)" || die
}

src_install() {
	if [ "${KERNEL}" = "linux" ]; then
		linux-mod_src_install
	else
		insinto /boot/modules
		doins "${S}"/dazuko.kld
		exeinto /boot/modules
		doexe "${S}"/dazuko.ko
	fi

	dolib.a library/libdazuko.a
	insinto /usr/include
	doins dazukoio.h
	doins dazuko_events.h

	dodoc README*
}

src_test() {
	if [ "${EUID}" != 0 ]; then
		ewarn "Cannot test while not root"
	else
		emake test || die "Test failed"
	fi
}

pkg_postinst() {
	[ "${KERNEL}" = "linux" ] && linux-mod_pkg_postinst
}

pkg_postrm() {
	[ "${KERNEL}" = "linux" ] && linux-mod_pkg_postrm
}
