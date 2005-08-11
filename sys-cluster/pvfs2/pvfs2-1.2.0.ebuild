# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/pvfs2/pvfs2-1.2.0.ebuild,v 1.1 2005/08/11 18:00:51 robbat2 Exp $

inherit kernel-mod eutils

DESCRIPTION="Parallel Virtual File System version 2"
HOMEPAGE="http://www.pvfs.org/pvfs2/"
SRC_URI="ftp://ftp.parl.clemson.edu/pub/pvfs2/${P}.tar.gz"
IUSE="gtk debug static doc"
RDEPEND="gtk? ( >=x11-libs/gtk+-2 )
		 sys-libs/db"
DEPEND="${RDEPEND}
		virtual/linux-sources"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
S="${WORKDIR}/${P/_/}"

src_compile() {
	local myconf kernmodtarget
	myconf="--enable-mmap-racache `use_enable !static shared` `use_enable static`"
	if kernel-mod_is_2_6_kernel ; then
		myconf="${myconf} --with-kernel=${KERNEL_DIR} --enable-epoll"
		kernmodtarget="kmod"
	else
		myconf="${myconf} --with-kernel24=${KERNEL_DIR}"
		kernmodtarget="kmod24"
	fi
	myconf="${myconf} `use_enable gtk karma`"
	use !debug && append-flags -DNDEBUG -DGOSSIP_DISABLE_DEBUG

	econf ${myconf} || die "econf failed!"
	einfo "Building main code"
	emake || die "main compile failed"

	# this fails dismally if $ARCH is set
	einfo "Building kernel module (${kernmodtarget})"
	OLDARCH="${ARCH}"
	unset ARCH
	emake ${kernmodtarget} || die "kernel module install failed"
	export ARCH="${OLDARCH}"
}

src_install() {
	local kernmodtarget
	if kernel-mod_is_2_6_kernel ; then
		kernmodtarget="kmod"
	else
		kernmodtarget="kmod24"
	fi

	# this fails dismally if $ARCH is set
	OLDARCH="${ARCH}"
	unset ARCH
	make install ${kernmodtarget}_install prefix="${D}/usr" mandir="${D}/usr/share/man" kmod_prefix="${D}" || die "install failed"
	export ARCH="${OLDARCH}"

	dodoc AUTHORS CREDITS ChangeLog INSTALL README
	docinto examples
	dodoc examples/{fs.conf,pvfs2-server.rc,server.conf-localhost}
	# this is LARGE (~5mb)
	if use docs; then
		docdir="/usr/share/doc/${PF}/"
		cp -ra ${S}/doc ${D}${docdir}
		rm -rf ${D}${docdir}/man
	fi
}
