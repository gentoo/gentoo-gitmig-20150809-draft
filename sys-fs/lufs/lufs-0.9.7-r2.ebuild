# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lufs/lufs-0.9.7-r2.ebuild,v 1.6 2004/07/16 18:57:59 mr_bones_ Exp $

inherit kmod eutils

KMOD_SOURCES="${P}.tar.gz"
DESCRIPTION="User-mode filesystem implementation"
HOMEPAGE="http://lufs.sourceforge.net/lufs/"
SRC_URI="mirror://sourceforge/lufs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug disablekernelsupport lufsusermount"

DEPEND="virtual/linux-sources
	sys-kernel/config-kernel"
RDEPEND=""

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
	myconf="--enable-wavfs --enable-cardfs"
	if use disablekernelsupport; then
		myconf="${myconf} --disable-kernel-support"
	fi
	if ! use lufsusermount; then
		myconf="${myconf} --disable-suid"
	fi
	if [ "`portageq has_version / sys-fs/autofs`" == "0" ]   ; then
		myconf="${myconf} --enable-autofs-install"
	fi
	if use debug; then
		myconf="${myconf} --enable-debug --enable-kdebug"
	fi
	unset ARCH
	econf ${myconf} || die
	kmod_src_compile || die "kmod_src_compile failed"
}

src_install () {
	kmod_make_linux_writable
	dodoc AUTHORS ChangeLog Contributors INSTALL \
		NEWS README THANKS TODO
	dohtml docs/lufs.html
	env -u ARCH make DESTDIR=${D} install
	if ! use disablekernelsupport; then
		insinto ${ROOT}/lib/modules/${KV}/fs/lufs
		doins kernel/Linux/2.${KV_PATCH}/lufs.$KV_OB
	fi
}

pkg_postinst() {
	kmod_pkg_postinst
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
	if [ ! "$( egrep "^CONFIG_LUFS_FS=[ym]" /lib/modules/${KV}/build/.config )" ]; then
		/sbin/modprobe -r lufs
	fi
}
