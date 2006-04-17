# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/util-linux/util-linux-2.12r-r3.ebuild,v 1.10 2006/04/17 20:35:12 corsair Exp $

inherit eutils flag-o-matic toolchain-funcs

OLD_CRYPT_VER=2.12i
LOOP_AES_VER=3.1c
DESCRIPTION="Various useful Linux utilities"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/util-linux/"
SRC_URI="mirror://kernel/linux/utils/${PN}/${P}.tar.bz2
	old-crypt? (
		mirror://kernel/linux/utils/${PN}/${PN}-${OLD_CRYPT_VER}.tar.gz
		mirror://gentoo/util-linux-${OLD_CRYPT_VER}-cryptoapi-losetup.patch.bz2
	)
	crypt? ( http://loop-aes.sourceforge.net/loop-AES/loop-AES-v${LOOP_AES_VER}.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE="crypt old-crypt nls static selinux perl"

RDEPEND=">=sys-libs/ncurses-5.2-r2
	>=sys-fs/e2fsprogs-1.34
	selinux? ( sys-libs/libselinux )
	crypt? ( app-crypt/hashalot )
	perl? ( dev-lang/perl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	virtual/os-headers"

OLD_CRYPT_P=${WORKDIR}/${PN}-${OLD_CRYPT_VER}

yesno() { useq $1 && echo yes || echo no; }

src_unpack() {
	unpack ${A}

	# Old crypt support
	if use old-crypt ; then
		cd "${OLD_CRYPT_P}"
		ewarn "You should update your system as USE=old-crypt"
		ewarn "support will be dropped in future versions."
		epatch "${WORKDIR}"/util-linux-${OLD_CRYPT_VER}-cryptoapi-losetup.patch
	fi

	cd "${S}"

	# crypto support
	use crypt && epatch "${WORKDIR}"/loop-AES-v${LOOP_AES_VER}/${P}.diff

	# Fall back to cracklib if default words file doesnt exist #114416
	epatch "${FILESDIR}"/${PN}-2.12r-cracklib-words.patch

	# Fix rare failures with -j4 or higher
	epatch "${FILESDIR}"/${PN}-2.11z-parallel-make.patch

	# Fix -f usage with -a and in general
	epatch "${FILESDIR}"/${PN}-2.12q-more-fake-checks-v2.patch

	# Fix mtab updates with `mount --move /foo /bar` #104697
	epatch "${FILESDIR}"/${PN}-2.12q-update-mtab-when-moving.patch

	# Respect -n with -r and umount #98675
	epatch "${FILESDIR}"/${PN}-2.12q-umount-dont-write-mtab-with-remount.patch

	# A few fixes to beat update_mtab() into submission.
	epatch "${FILESDIR}"/${PN}-2.12q-update_mtab-fixes.patch

	# Use update_mtab() to avoid dups in mtab for 'mount -f'
	epatch "${FILESDIR}"/${PN}-2.12q-use-update_mtab-for-fake.patch

	# Fix unreadable df output when using devfs ... this check is kind of
	# a hack, but whatever, the output isnt critical at all :P
	[[ -e /dev/.devfsd ]] && epatch "${FILESDIR}"/no-symlink-resolve.patch

	# Add the O option to agetty to display DNS domainname in the issue
	# file, thanks to Marius Mauch <genone@genone.de>, bug #22275.
	#
	# NOTE:  Removing this will break future baselayout, so PLEASE
	#        consult with me before doing so.
	epatch "${FILESDIR}"/${PN}-2.11z-agetty-domainname-option.patch

	# Fix french translation typo #75693
	epatch "${FILESDIR}"/${PN}-2.12q-i18n-update.patch

	# Add NFS4 support (kernel 2.5/2.6)
	epatch "${FILESDIR}"/${PN}-2.12i-nfsv4.patch

	# ignore managed/kudzu options #70873
	epatch "${FILESDIR}"/${PN}-2.12i-ignore-managed.patch

	# swapon gets confused by symlinks in /dev #69162
	epatch "${FILESDIR}"/${PN}-2.12p-swapon-check-symlinks.patch

	# fix simple buffer overflow (from Debian)
	epatch "${FILESDIR}"/${PN}-2.12q-debian-10cfdisk.patch

	# don't build fdisk on m68k
	epatch "${FILESDIR}"/${PN}-2.12q-no-m68k-fdisk.patch

	# don't force umask to 022 #93671
	epatch "${FILESDIR}"/${PN}-2.12q-dont-umask.patch

	# fix cal display when using featureless terminals #112406
	epatch "${FILESDIR}"/${PN}-2.12r-cal-dumb-terminal.patch

	# Bug #108988 unable to always seek when omiting frame pointers
	epatch "${FILESDIR}"/${PN}-2.12r-fdisk-frame-pointers.patch

	# Patches from Fedora
	epatch "${FILESDIR}"/${PN}-2.12r-umount-nosysfs.patch

	# Enable random features
	local mconfigs="MCONFIG"
	use old-crypt && mconfigs="${mconfigs} ${OLD_CRYPT_P}/MCONFIG"
	sed -i \
		-e "/^HAVE_SELINUX=/s:no:$(yesno selinux):" \
		-e "/^DISABLE_NLS=/s:no:$(yesno !nls):" \
		-e "/^HAVE_KILL=/s:no:yes:" \
		-e "/^HAVE_SLN=/s:no:yes:" \
		-e "/^HAVE_TSORT/s:no:yes:" \
		-e "s:-pipe -O2 \$(CPUOPT) -fomit-frame-pointer:${CFLAGS}:" \
		-e "s:CPU=.*:CPU=${CHOST%%-*}:" \
		-e "s:SUIDMODE=.*4755:SUIDMODE=4711:" \
		${mconfigs} || die "MCONFIG sed"
}

src_compile() {
	append-ldflags $(bindnow-flags)
	use static && append-ldflags -static
	export CC="$(tc-getCC)"

	econf || die "configure failed"
	emake || die "emake failed"

	cd partx
	has_version '>=sys-kernel/linux-headers-2.6' && append-flags -include linux/compiler.h
	emake CFLAGS="${CFLAGS}" || die "make partx failed"

	if use old-crypt ; then
		cd "${OLD_CRYPT_P}"
		econf || die "old configure failed"
		emake -C lib || die "old lib failed"
		emake -C mount losetup mount || die "old make failed"
	fi
}

src_install() {
	make install DESTDIR="${D}" || die "install failed"
	dosym ../man8/agetty.8 /usr/share/man/man1/getty.1
	dosbin partx/{addpart,delpart,partx} || die "dosbin"
	use perl || rm -f "${D}"/usr/bin/chkdupexe

	newinitd "${FILESDIR}"/crypto-loop.initd crypto-loop
	newconfd "${FILESDIR}"/crypto-loop.confd crypto-loop

	# man-pages installs renice(1p) but util-linux does renice(8)
	dosym ../man8/renice.8 /usr/share/man/man1/renice.1

	dodoc HISTORY MAINTAINER README VERSION
	docinto examples
	dodoc example.files/*

	if use old-crypt ; then
		cd "${OLD_CRYPT_P}"/mount
		into /
		newbin mount mount-old-crypt || die
		newbin losetup losetup-old-crypt || die
		fperms 4711 /bin/{mount,losetup}-old-crypt
	fi
}

pkg_postinst() {
	if ! use old-crypt ; then
		ewarn "This version of util-linux includes crypto support"
		ewarn "for loop-aes instead of the old cryptoapi."
		ewarn "If you need the older support, please re-emerge"
		ewarn "util-linux with USE=old-crypt.  This will create"
		ewarn "/sbin/mount-old-crypt and /sbin/losetup-old-crypt."
	fi
}
