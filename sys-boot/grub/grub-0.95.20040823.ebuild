# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/grub/grub-0.95.20040823.ebuild,v 1.8 2004/12/08 01:20:35 robbat2 Exp $

inherit mount-boot eutils flag-o-matic gcc gnuconfig toolchain-funcs

DESCRIPTION="GNU GRUB boot loader"
HOMEPAGE="http://www.gnu.org/software/grub/"
SRC_URI="mirror://gentoo/${P}.tar.gz
	mirror://gentoo/${P}-splash.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="static netboot"

DEPEND=">=sys-libs/ncurses-5.2-r5
	>=sys-devel/automake-1.7
	>=sys-devel/autoconf-2.5"
PROVIDE="virtual/bootloader"

src_unpack() {
	has_m32 || die "Your compiler seems to be unable to compile 32-bit code. If you are on amd64, make sure you compile gcc with USE=multilib FEATURES=-sandbox"

	unpack ${A}
	cd ${S}

	gnuconfig_update

	epatch ${WORKDIR}/${P}-splash.patch
	#epatch ${FILESDIR}/${P}-gcc3.4.patch

	# Trying to get rid of the need for the ugly menu.lst -> grub.conf symlink
	#epatch ${FILESDIR}/${P}-grub.conf.patch

	# This patchset is from SuSE -- hopefully fixes the acl symlink issue
	# And should add some boot prettification
	# epatch ${WORKDIR}/${PF}-gentoo.diff
	# epatch ${FILESDIR}/${P}-test.patch

	# -fwritable-strings is deprecated; testing to see if we need it any more
	epatch ${FILESDIR}/${P}-warnings.patch
}

src_compile() {
	### i686-specific code in the boot loader is a bad idea; disabling to ensure
	### at least some compatibility if the hard drive is moved to an older or
	### incompatible system.
	unset CFLAGS

	filter-ldflags -pie
	append-flags -DNDEBUG
	[ `gcc-major-version` -eq 3 ] && append-flags -minline-all-stringops
	use static && append-ldflags -static

	has_pie && CC="$(tc-getCC) `test_flag -fno-pic` `test_flag -nopie`"
	has_ssp && CC="$(tc-getCC) `test_flag -fno-stack-protector`"

	autoconf || die "autoconf failed"
	aclocal || die "aclocal failed"
	WANT_AUTOMAKE=1.7 automake || die "automake failed"

	# build the net-bootable grub first, but only if "netboot" is set
	if use netboot
	then
		CFLAGS="" \
		econf \
		--datadir=/usr/lib/grub \
		--exec-prefix=/ \
		--disable-auto-linux-mem-opt \
		--enable-diskless \
		--enable-{3c{5{03,07,09,29,95},90x},cs89x0,davicom,depca,eepro{,100}} \
		--enable-{epic100,exos205,ni5210,lance,ne2100,ni{50,65}10,natsemi} \
		--enable-{ne,ns8390,wd,otulip,rtl8139,sis900,sk-g16,smc9000,tiara} \
		--enable-{tulip,via-rhine,w89c840} || die "netboot econf failed"

		emake w89c840_o_CFLAGS="-O" || die "making netboot stuff"

		mv stage2/{nbgrub,pxegrub} ${S}
		mv stage2/stage2 stage2/stage2.netboot

		make clean || die "make clean failed"
	fi

	# Now build the regular grub
	# Note that FFS and UFS2 support are broken for now - stage1_5 files too big
	CFLAGS="${CFLAGS}" \
	econf \
			--datadir=/usr/lib/grub \
			--exec-prefix=/ \
			--disable-auto-linux-mem-opt || die "econf failed"
	emake || die "making regular stuff"
}

src_install() {
	make DESTDIR=${D} install || die
	exeinto /usr/lib/grub
	doexe stage2/stage2
	use netboot && doexe nbgrub pxegrub stage2/stage2.netboot

	insinto /boot/grub
	doins ${FILESDIR}/splash.xpm.gz
	newins docs/menu.lst grub.conf.sample

	dodoc AUTHORS BUGS COPYING ChangeLog NEWS README THANKS TODO
	newdoc docs/menu.lst grub.conf.sample
}

pkg_postinst() {
	[ "$ROOT" != "/" ] && return 0

	# change menu.lst to grub.conf
	if [ ! -e /boot/grub/grub.conf -a -e /boot/grub/menu.lst ]
	then
		mv /boot/grub/menu.lst /boot/grub/grub.conf
		ewarn
		ewarn "*** IMPORTANT NOTE: menu.lst has been renamed to grub.conf"
		ewarn
	fi
	einfo "Linking from new grub.conf name to menu.lst"
	ln -s grub.conf /boot/grub/menu.lst

	[ -e /boot/grub/stage2 ] && mv /boot/grub/stage2{,.old}

	einfo "Copying files from /usr/lib/grub to /boot"
	cp -p /usr/lib/grub/* /boot/grub
	cp -p /lib/grub/*/* /boot/grub
	cp -p /usr/lib/grub/*/* /boot/grub

	[ -e /boot/grub/grub.conf ] \
		&& /sbin/grub \
			--batch \
			--device-map=/boot/grub/device.map \
			< /boot/grub/grub.conf > /dev/null 2>&1
}
