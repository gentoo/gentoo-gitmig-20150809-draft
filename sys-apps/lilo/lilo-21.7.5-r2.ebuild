# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lilo/lilo-21.7.5-r2.ebuild,v 1.4 2002/07/20 19:01:50 gerk Exp $

#
# This lilo has the Suse animated bootlogo patches.. fun!
#

S=${WORKDIR}/${P}
DESCRIPTION="Standard Linux boot loader"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/boot/lilo/${P}.tar.gz"
HOMEPAGE="http://brun.dyndns.org/pub/linux/lilo/"
KEYWORDS="x86 -ppc -sparc -sparc64"
SLOT="0"
LICENSE="BSD"
DEPEND="virtual/glibc >=sys-devel/bin86-0.15.5"
RDEPEND="virtual/glibc"

pkg_setup() {
	[ "${ROOT}" != "/" ] && return 0
	. ${ROOT}/etc/init.d/functions.sh
	local fstabstate="$(cat /etc/fstab |grep -v -e '#' |awk '{print $2}')"
	local procstate="$(cat /proc/mounts |awk '{print $2}')"
	if [ -n "$(echo ${fstabstate} |grep -e "/boot")" ] && \
	   [ -n "$(echo ${procstate} |grep -e "/boot")" ]
	then
		einfo "Your boot partition was detected as being mounted as /boot."
		einfo "Files will be installed there for lilo to function correctly."
	elif [ -n "$(echo ${fstabstate} |grep -e "/boot")" ] && \
	     [ -z "$(echo ${procstate} |grep -e "/boot")" ]
	then
		mount /boot &>/dev/null
		if [ "$?" -eq 0 ]
		then
			einfo "Your boot partition was not mounted as /boot, but portage was able to mount"
			einfo "it without additional intervention."
			einfo "Files will be installed there for lilo to function correctly."
		else
			eerror "Your boot partition has to be mounted on /boot before the installation"
			eerror "can continue. Lilo needs to install important files there."
			die "Please mount your /boot partition."
		fi
	else
		einfo "You do not have a seperate /boot partition."
	fi
}

src_unpack() {
	unpack ${A} ; cd ${S}

	# patches for animated boot logo from Suse.  loopdev fix too.
	patch -p1 < ${FILESDIR}/${PV}/lilo-21.7.4.diff || die
	patch -p1 < ${FILESDIR}/${PV}/lilo-21.7.4-loop_dev.diff || die
	patch -p1 < ${FILESDIR}/${PV}/lilo-21.7.4-gfx.diff || die
	patch -p0 < ${FILESDIR}/${PV}/lilo-21.7-vga_inst.diff || die

	mv Makefile Makefile.orig
	sed -e "s:-g::" Makefile.orig > Makefile
}

src_compile() {
	make || die "compile problem"
}

src_install() {
	into /
	dosbin lilo
	into /usr
	dosbin keytab-lilo.pl
	dodir /boot
	insinto /boot
	doins boot-text.b boot-menu.b chain.b os2_d.b
	doman manPages/*.[5-8]
	dodoc CHANGES COPYING INCOMPAT QuickInst README*

	insinto /etc
	newins ${FILESDIR}/lilo.conf lilo.conf.example
}

pkg_preinst() {
	if [ ! -L $ROOT/boot/boot.b -a -f $ROOT/boot/boot.b ]
	then
	    einfo "Saving old boot.b..."
	    mv $ROOT/boot/boot.b $ROOT/boot/boot.old
	fi

	if [ ! -L $ROOT/boot/chain.b -a -f $ROOT/boot/chain.b ]
	then
	    einfo "Saving old chain.b..."
	    mv $ROOT/boot/chain.b $ROOT/boot/chain.old
	fi

	if [ ! -L $ROOT/boot/os2_d.b -a -f $ROOT/boot/os2_d.b ]
	then
	    einfo "Saving old os2_d.b..."
	    mv $ROOT/boot/os2_d.b $ROOT/boot/os2_d.old
	fi
}

pkg_postinst() {
	einfo "Activating boot-menu..."
	ln -sf boot-menu.b $ROOT/boot/boot.b

	echo
	echo "*****************************************************"
	echo "* You need to use: message=/boot/foo.boot in your   *"
	echo "* /etc/lilo.conf global section.                    *"
	echo "*                                                   *"
	echo "* See http://www.gamers.org/~quinet/lilo/index.html *"
	echo "* for downloadable animations.                      *"
	echo "*****************************************************"
	echo
}
