# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/rivatv/rivatv-0.8.5-r2.ebuild,v 1.1 2005/01/10 00:54:38 blauwers Exp $

S=${WORKDIR}/${P/_/-}
DESCRIPTION="kernel driver for nVidia based cards with video-in"
SRC_URI="mirror://sourceforge/rivatv/${P/_/-}.tar.gz"
HOMEPAGE="http://rivatv.sourceforge.net/"
DEPEND="virtual/x11
	>=virtual/linux-sources-2.4.17"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

src_unpack() {
	check_KV
	unpack ${A}

	epatch ${FILESDIR}/${P/_/-}-configure.patch

	# Symlink kernel source to a directory we have permissions for
	mkdir ${WORKDIR}/build
	cd ${WORKDIR}/build
	SRC=/lib/modules/${KV}/build
	for f in ${SRC}/.config ${SRC}/.version ${SRC}/*; do ln -s $f; done
}


src_compile() {
	# Alter Makefile.in to install into an alternate directory and
	# set the kernel source path to the build folder
	cd ${S}
	sed 's/\@KERNEL\@/\$\{KDIR\}/' Makefile.in > Makefile.in.new || die
	mv -f Makefile.in.new Makefile.in || die
	sed 's/install\: devices/install\:/' Makefile.in > Makefile.in.new || die
	mv -f Makefile.in.new Makefile.in || die
	sed 's/\/lib\/modules\//\$\{D\}lib\/modules\//' Makefile.in > Makefile.in.new || die
	mv -f Makefile.in.new Makefile.in || die
	sed 's/\$(DEPMOD)/echo replaced/' Makefile.in > Makefile.in.new || die
	mv -f Makefile.in.new Makefile.in || die

	# Configure and build
	set_arch_to_kernel
	econf || die
	emake KDIR=${WORKDIR}/build ARCH=i386 V=1 DEPMOD='' || die
}

src_install () {
	# Create kernel modules folder in the image directory
	dodir lib/modules/${KV}/kernel

	# Install to the image directory
	make install DESTDIR=${D} || die
	set_arch_to_portage
}

pkg_postinst() {
	# Update modules
	depmod -a

	# If devfsd is not being used create devices
	if [ "${ROOT}" = "/" ]
	then
		if [ ! -e /dev/.devfsd ] && [ ! -e /dev/video0 ]
		then
			# Create devices
			mknod /dev/video0 c 81 0
			chmod 660 /dev/video0
			mknod /dev/video1 c 81 0
			chmod 660 /dev/video1
			mknod /dev/video2 c 81 0
			chmod 660 /dev/video2
			mknod /dev/video3 c 81 0
			chmod 660 /dev/video3
			ln -s /dev/video0 /dev/video
		fi
	fi

	einfo "To load the module automatically at boot up, add these and"
	einfo "\"rivatv\" to your /etc/modules.autoload."
	einfo
	einfo "Also, see ${HOMEPAGE} for more information."
}

pkg_postrm() {
	# Update modules
	depmod -a
	einfo "If you added modules to /etc/modules.autoload remember to"
	einfo "remove them now."
}
