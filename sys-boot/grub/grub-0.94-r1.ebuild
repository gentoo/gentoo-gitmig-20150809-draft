# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/grub/grub-0.94-r1.ebuild,v 1.3 2004/04/07 01:06:09 solar Exp $

inherit mount-boot eutils flag-o-matic gcc

DESCRIPTION="GNU GRUB boot loader"
HOMEPAGE="http://www.gnu.org/software/grub/"
SRC_URI="ftp://alpha.gnu.org/gnu/grub/${P}.tar.gz
	http://dev.gentoo.org/~spock/portage/distfiles/${P}-splash.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"
IUSE="static"

DEPEND=">=sys-libs/ncurses-5.2-r5
	>=sys-devel/autoconf-2.5"
PROVIDE="virtual/bootloader"

src_unpack() {
	unpack ${A} || die
	cd ${S} || die

	epatch ${WORKDIR}/${P}-splash.patch

	# grub-0.93.20030118-gentoo.diff; <woodchip@gentoo.org> (18 Jan 2003)
	# -fixes from grub CVS pulled on 20030118
	# -vga16 patches; mined from Debian's grub-0.93+cvs20030102-1.diff
	# -special-raid-devices.patch
	# -addsyncs.patch
	# -splashimagehelp.patch
	# -configfile.patch
	# -installcopyonly.patch

	# This patchset is from SuSE -- hopefully fixes the acl symlink issue
	# And should add some boot prettification
#	epatch ${WORKDIR}/${PF}-gentoo.diff
#	epatch ${FILESDIR}/${P}-test.patch
}

src_compile() {
	### i686-specific code in the boot loader is a bad idea; disabling to ensure
	### at least some compatibility if the hard drive is moved to an older or
	### incompatible system.
	unset CFLAGS

	filter-flags -fstack-protector
	filter-ldflags -pie
	append-flags -DNDEBUG
	[ `gcc-major-version` -eq 3 ] && append-flags -minline-all-stringops
	use static && append-ldflags -static

	# http://www.gentoo.org/proj/en/hardened/etdyn-ssp.xml
	if has_version 'sys-devel/hardened-gcc' && [ "$(gcc-getCC)" == "gcc" ] ; then
		# the configure script has problems with -nostdlib
		CC="${CC} -yet_exec -yno_propolice"
	fi

	autoconf || die
	aclocal || die
	automake || die

	# build the net-bootable grub first
	CFLAGS="" \
	econf \
		--datadir=/usr/lib/grub \
		--exec-prefix=/ \
		--disable-auto-linux-mem-opt \
		--enable-diskless \
		--enable-{3c{5{03,07,09,29,95},90x},cs89x0,davicom,depca,eepro{,100}} \
		--enable-{epic100,exos205,ni5210,lance,ne2100,ni{50,65}10,natsemi} \
		--enable-{ne,ns8390,wd,otulip,rtl8139,sis900,sk-g16,smc9000,tiara} \
		--enable-{tulip,via-rhine,w89c840} || die

	emake w89c840_o_CFLAGS="-O" || die "making netboot stuff"

	mv stage2/{nbgrub,pxegrub} ${S}
	mv stage2/stage2 stage2/stage2.netboot

	make clean || die

	# now build the regular grub
	CFLAGS="${CFLAGS}" \
	econf \
			--datadir=/usr/lib/grub \
			--exec-prefix=/ \
			--disable-auto-linux-mem-opt || die
	emake || die "making regular stuff"
}

src_install() {
	make DESTDIR=${D} install || die
	exeinto /usr/lib/grub
	doexe nbgrub pxegrub stage2/stage2 stage2/stage2.netboot

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
	cp -p /usr/lib/grub/grub/*/* /boot/grub

	[ -e /boot/grub/grub.conf ] \
		&& /usr/sbin/grub \
			--batch \
			--device-map=/boot/grub/device.map \
			< /boot/grub/grub.conf > /dev/null 2>&1
}
