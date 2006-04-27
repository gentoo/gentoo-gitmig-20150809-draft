# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qemu-softmmu/qemu-softmmu-0.8.0.20060329.ebuild,v 1.2 2006/04/27 22:21:46 lu_zero Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Multi-platform & multi-targets cpu emulator and dynamic translator"
HOMEPAGE="http://fabrice.bellard.free.fr/qemu/"
SRC_URI="mirror://gentoo/${P/-softmmu/}.tar.bz2"


LICENSE="GPL-2 LGPL-2.1 KQEMU"
SLOT="0"
KEYWORDS="-alpha amd64 ~ppc -sparc ~x86"
IUSE="sdl kqemu alsa"  #qvm86 debug nptl qemu-fast nptlonly"
RESTRICT="nostrip"


RDEPEND="sdl? ( media-libs/libsdl )
		 kqemu? ( app-emulation/kqemu )"

DEPEND="${RDEPEND}
		virtual/libc
		!<=app-emulation/qemu-0.7.0
		app-text/texi2html"

S="${WORKDIR}/${P/-softmmu/}"

set_target_list() {
	TARGET_LIST="i386-softmmu ppc-softmmu sparc-softmmu x86_64-softmmu arm-softmmu mips-softmmu"
	export TARGET_LIST
}

pkg_setup() {
	if [ "$(gcc-major-version)" == "4" ]; then
		ewarn "Qemu could not build with GCC 4"
	fi
}

#RUNTIME_PATH="/emul/gnemul/"
src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/qemu-0.8.0-stwbrx.patch
	# Alter target makefiles to accept CFLAGS set via flag-o.
	sed -i 's/^\(C\|OP_C\|HELPER_C\)FLAGS=/\1FLAGS+=/' \
		Makefile Makefile.target tests/Makefile
	# Ensure mprotect restrictions are relaxed for emulator binaries
	[[ -x /sbin/paxctl ]] && \
		sed -i 's/^VL_LDFLAGS=$/VL_LDFLAGS=-Wl,-z,execheap/' \
			Makefile.target
	# Prevent install of kernel module by qemu's makefile
	sed -i 's/\(.\/install.sh\)/#\1/' Makefile
}

src_compile() {
	#Let the application set its cflags
	unset CFLAGS

	# Switch off hardened tech
	filter-flags -fpie -fstack-protector

	myconf="--disable-gcc-check"
	if ! use sdl ; then
		myconf="$myconf --disable-gfx-check"
	fi
	set_target_list
#		--interp-prefix=${RUNTIME_PATH}/qemu-%M
	./configure \
		--prefix=/usr \
		--target-list="${TARGET_LIST}" \
		--enable-slirp \
		--kernel-path=${KV_DIR} \
		$(use_enable kqemu) \
		$(use_enable alsa)\
		$(use_enable sdl)\
		$(use_enable kqemu)\
		${myconf} \
		|| die "could not configure"

	emake || die "make failed"
}

src_install() {
	make install \
		prefix=${D}/usr \
		bindir=${D}/usr/bin \
		datadir=${D}/usr/share/qemu \
		docdir=${D}/usr/share/doc/${P} \
		mandir=${D}/usr/share/man || die

	chmod -x ${D}/usr/share/man/*/*
}

pkg_postinst() {
	einfo "You will need the Universal TUN/TAP driver compiled into"
	einfo "kernel or as a module to use the virtual network device."
}
