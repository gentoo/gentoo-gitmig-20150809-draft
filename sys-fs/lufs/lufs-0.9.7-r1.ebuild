# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lufs/lufs-0.9.7-r1.ebuild,v 1.5 2004/04/27 21:53:44 agriffis Exp $

inherit kmod eutils

S="${WORKDIR}/${P}"
DESCRIPTION="User-mode filesystem implementation"
SRC_URI="mirror://sourceforge/lufs/${P}.tar.gz"
KMOD_SOURCES="${P}.tar.gz"
HOMEPAGE="http://lufs.sourceforge.net/lufs/"
LICENSE="GPL-2"
DEPEND="virtual/linux-sources
	sys-kernel/config-kernel"
RDEPEND=""
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE="lufsusermount"

src_unpack() {
	kmod_src_unpack
	cd ${S}

	epatch ${FILESDIR}/${P}-fPIC.patch

	# Fix some sandbox failures
	sed -i -e's/install-data-hook//' \
		lufsd/Makefile.in util/Makefile.in kernel/Linux/2.4/Makefile.in

	# Fix GCC 3.3.2 build failure (see also
	# http://gcc.gnu.org/bugzilla/show_bug.cgi?id=13192)
	epatch ${FILESDIR}/gentoo-gcc332fix-${PV}.patch
}

src_compile() {
	kmod_make_linux_writable
	local myconf
	myconf="--enable-wavfs --enable-cefs --enable-cardfs"
	econf ${myconf} || die
	env -u ARCH emake || die
}

src_install () {
	dodoc AUTHORS COPYING ChangeLog Contributors INSTALL \
		NEWS README THANKS TODO
	dohtml docs/lufs.html
	make DESTDIR=${D} install

	dosym /usr/bin/auto.sshfs /etc/auto.sshfs
	dosym /usr/bin/auto.ftpfs /etc/auto.ftpfs
	dodir /sbin
	dosym /usr/bin/lufsd /sbin/mount.lufs
	use lufsusermount && chmod +s ${D}/usr/bin/lufs{mnt,umount}
}

pkg_postinst() {
	if [ ! "$( egrep "^CONFIG_LUFS_FS=[ym]" /usr/src/linux-${KV}/.config )" ]; then
		/usr/sbin/update-modules
	fi

	if ! use lufsusermount
	then
		einfo If you want regular users to be able to mount lufs filesystems,
		einfo you need to run the following command as root:
		einfo \# chmod +s /usr/bin/lufsmnt /usr/bin/lufsumount
		einfo You can also set the lufsusermount USE flag to do this
		einfo automatically.
	fi
}

pkg_postrm() {
	if [ ! "$( egrep "^CONFIG_LUFS_FS=[ym]" /usr/src/linux-${KV}/.config )" ]; then
		/sbin/modprobe -r lufs
	fi
}
