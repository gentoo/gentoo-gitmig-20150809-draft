# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/util-linux/util-linux-2.13_pre6.ebuild,v 1.6 2006/04/11 00:35:43 vapier Exp $

inherit eutils flag-o-matic toolchain-funcs

MY_PV=${PV/_/-}
MY_P=${PN}-${MY_PV}
S=${WORKDIR}/${MY_P}

LOOP_AES_VER=3.1d
DESCRIPTION="Various useful Linux utilities"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/util-linux/"
SRC_URI="mirror://kernel/linux/utils/${PN}/testing/${MY_P}.tar.bz2
	crypt? ( http://loop-aes.sourceforge.net/loop-AES/loop-AES-v${LOOP_AES_VER}.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="crypt nls static selinux perl"

RDEPEND="!sys-process/schedutils
	>=sys-libs/ncurses-5.2-r2
	>=sys-fs/e2fsprogs-1.34
	selinux? ( sys-libs/libselinux )
	crypt? ( app-crypt/hashalot )
	perl? ( dev-lang/perl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	virtual/os-headers"

yesno() { useq $1 && echo yes || echo no; }

src_unpack() {
	unpack ${A}

	cd "${S}"

	# crypto support
	use crypt && die "Sorry, no loop-AES support in this version"
#	use crypt && epatch "${WORKDIR}"/loop-AES-v${LOOP_AES_VER}/util-linux-2.12r.diff

	# Fall back to cracklib if default words file doesnt exist #114416
	epatch "${FILESDIR}"/${PN}-2.12r-cracklib-words.patch

	# Fix -f usage with -a and in general
	epatch "${FILESDIR}"/${PN}-2.12q-more-fake-checks-v2.patch

	# Fix mtab updates with `mount --move /foo /bar` #104697
	epatch "${FILESDIR}"/${PN}-2.12q-update-mtab-when-moving.patch

	# A few fixes to beat update_mtab() into submission.
	epatch "${FILESDIR}"/${PN}-2.12q-update_mtab-fixes.patch

	# Use update_mtab() to avoid dups in mtab for 'mount -f'
	epatch "${FILESDIR}"/${PN}-2.12q-use-update_mtab-for-fake.patch

	# Fix building with USE=-nls #123826
	epatch "${FILESDIR}"/${PN}-2.13-no-nls.patch

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

#	# Add NFS4 support (kernel 2.5/2.6)
#	epatch "${FILESDIR}"/${PN}-2.13-nfsv4.patch

	# ignore managed/kudzu options #70873
	epatch "${FILESDIR}"/${PN}-2.12i-ignore-managed.patch

	# swapon gets confused by symlinks in /dev #69162
	epatch "${FILESDIR}"/${PN}-2.12p-swapon-check-symlinks.patch

	# don't force umask to 022 #93671
	epatch "${FILESDIR}"/${PN}-2.12q-dont-umask.patch

	# fix cal display when using featureless terminals #112406
	epatch "${FILESDIR}"/${PN}-2.12r-cal-dumb-terminal.patch

	sed -i -e '/chmod/s:4755:4711:' mount/Makefile.in
}

src_compile() {
#	append-ldflags $(bindnow-flags)
	use static && append-ldflags -static
	econf \
		--prefix=/ \
		$(use_with selinux) \
		$(use_enable nls) \
		--without-pam \
		--enable-agetty \
		--enable-cramfs \
		--disable-init \
		--disable-kill \
		--disable-last \
		--disable-mesg \
		--enable-partx \
		--enable-raw \
		--enable-rdev \
		--enable-rename \
		--disable-reset \
		--disable-login-utils \
		--enable-schedutils \
		--disable-wall \
		--enable-write \
		|| die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "install failed"
	dosym ../man8/agetty.8 /usr/share/man/man1/getty.1
	use perl || rm -f "${D}"/usr/bin/chkdupexe

	newinitd "${FILESDIR}"/crypto-loop.initd crypto-loop
	newconfd "${FILESDIR}"/crypto-loop.confd crypto-loop

	dodoc AUTHORS NEWS README
	docinto examples
	dodoc example.files/*
}
