# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

S=${WORKDIR}/${P}
DESCRIPTION="A stand alone memory test for x86 computers"
SRC_URI="http://www.teresaudio.com/memtest86/${P}.tar.gz"
HOMEPAGE="http://www.teresaudio.com/memtest86/"
KEYWORDS="x86 -ppc -sparc -sparc64"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc"
RDEPEND=""

pkg_setup() {
	[ "$ROOT" != "/" ] && return 0
	#If the user doesn't have a /boot or /mnt/boot filesystem, skip.
	[ -z "`grep /boot /etc/fstab | grep -v "^[ \t]*#"`" ] || return 0 
	local myboot
	myboot=`cat /etc/fstab | grep -v ^# | grep /boot | sed -e 's/^[^[:space:]]*[[:space:]]*\([^[:space:]]*\).*$/\1/'`
	[ `cat /proc/mounts | cut -f2 -d" " | grep $myboot` ] && return 0
	mount $myboot
	if [ $? -ne 0 ]
	then
		eerror "MEMTEST86 installation requires that $myboot is mounted or mountable."
		eerror "If you do not have a seperate /boot partition please remove any"
		eerror "/boot entries from /etc/fstab and make sure /boot exists."
		eerror ""
		eerror "Unable to mount $myboot automatically; exiting."
		die "Please mount your $myboot filesystema and remerge this ebuild."
	fi
}


src_compile() {
	cd ${S}
	patch -p1<${FILESDIR}/memtest86-3.0-gcc3-gentoo.patch
	emake || die
}

src_install() {

	dodir /boot/memtest86
	cp memtest.bin ${D}/boot/memtest86

	dodoc README README.build-process
	
}

pkg_postinst() {

	einfo '*** memtest.bin has been installed in /boot/memtest86, please remember to'
	einfo '*** update your boot loader. For example grub :'
	einfo "*** edit /boot/grub/menu.lst and add the following lines "
	einfo "***   > title=Memtest86"
	einfo "***   > root (hd0,0)"
	einfo "***   > kernel /boot/memtest86/memtest.bin"
}
