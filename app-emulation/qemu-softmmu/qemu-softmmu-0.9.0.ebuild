# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qemu-softmmu/qemu-softmmu-0.9.0.ebuild,v 1.8 2007/09/09 09:13:29 lu_zero Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Multi-platform & multi-targets cpu emulator and dynamic translator"
HOMEPAGE="http://fabrice.bellard.free.fr/qemu/"
SRC_URI="${HOMEPAGE}${P/-softmmu/}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="-alpha amd64 ppc -sparc x86"
IUSE="sdl kqemu alsa"  #qvm86 debug nptl qemu-fast nptlonly"
RESTRICT="strip test"

DEPEND="virtual/libc
	sdl? ( media-libs/libsdl )
	!<=app-emulation/qemu-0.7.0
	kqemu? ( >=app-emulation/kqemu-1.3.0_pre10 )
	app-text/texi2html"
RDEPEND="sdl? ( media-libs/libsdl )
		 alsa? ( media-libs/alsa-lib )"

S="${WORKDIR}/${P/-softmmu/}"

QA_TEXTRELS="usr/bin/qemu
	usr/bin/qemu-system-sparc
	usr/bin/qemu-system-arm
	usr/bin/qemu-system-ppc
	usr/bin/qemu-system-mips
	usr/bin/qemu-system-x86_64"
QA_EXECSTACK="usr/share/qemu/openbios-sparc32"
QA_WX_LOAD="usr/share/qemu/openbios-sparc32"

#set_target_list() {
#	TARGET_LIST="i386-softmmu ppc-softmmu sparc-softmmu x86_64-softmmu arm-softmmu mips-softmmu"
#	export TARGET_LIST
#}

pkg_setup() {
	if [ "$(gcc-major-version)" == "4" ]; then
	eerror "qemu requires gcc-3 in order to build and work correctly"
	eerror "please compile it switching to gcc-3."
	eerror "We are aware that qemu can guess a gcc-3 but this feature"
	eerror "could be harmful."
	die "gcc 4 cannot build qemu"
	fi
}

#RUNTIME_PATH="/emul/gnemul/"
src_unpack() {
	unpack ${A}

	cd ${S}
	# Alter target makefiles to accept CFLAGS set via flag-o.
	sed -i 's/^\(C\|OP_C\|HELPER_C\)FLAGS=/\1FLAGS+=/' \
		Makefile Makefile.target tests/Makefile
	# Ensure mprotect restrictions are relaxed for emulator binaries
	[[ -x /sbin/paxctl ]] && \
		sed -i 's/^VL_LDFLAGS=$/VL_LDFLAGS=-Wl,-z,execheap/' \
			Makefile.target
	# Prevent install of kernel module by qemu's makefile
	sed -i 's/\(.\/install.sh\)/#\1/' Makefile
	# avoid strip
	sed -i 's:$(INSTALL) -m 755 -s:$(INSTALL) -m 755:' Makefile Makefile.target

	epatch ${FILESDIR}/${P}-ide-cd.patch
}

src_compile() {
	#Let the application set its cflags
	unset CFLAGS

	# Switch off hardened tech
	filter-flags -fpie -fstack-protector

#	set_target_list

	myconf="--disable-gcc-check"
	if ! use sdl ; then
		myconf="$myconf --disable-gfx-check"
	fi
	./configure \
		--prefix=/usr \
		--enable-slirp --enable-adlib \
		--cc=$(tc-getCC) \
		--host-cc=$(tc-getCC) \
		--kernel-path=${KV_DIR} \
		--disable-linux-user \
		--enable-system \
		$(use_enable sdl)\
		$(use_enable kqemu) \
		$(use_enable alsa) \
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
