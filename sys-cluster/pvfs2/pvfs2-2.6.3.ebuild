# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/pvfs2/pvfs2-2.6.3.ebuild,v 1.1 2007/10/05 14:03:12 mabi Exp $

inherit linux-mod autotools toolchain-funcs

MY_PN="${PN%[0-9]*}"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Parallel Virtual File System version 2"
HOMEPAGE="http://www.pvfs.org/pvfs2/"
SRC_URI="ftp://ftp.parl.clemson.edu/pub/pvfs2/${MY_P}.tar.gz"
IUSE="gtk static doc"
RDEPEND="gtk? ( >=x11-libs/gtk+-2 )
		 sys-libs/db"
DEPEND="${RDEPEND}
		virtual/linux-sources"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"
S="${WORKDIR}/${MY_P}"

#Without this, the make kmod_install in src_install() would fail.
#ARCH=$(tc-arch-kernel)

pkg_setup() {
	linux-mod_pkg_setup

	if kernel_is 2 4; then
		BUILD_TARGETS="just_kmod24"
		ECONF_PARAMS="--with-kernel24=${KV_DIR}"
		MODULE_NAMES="pvfs2(fs::src/kernel/linux-2.4)"
	else
		BUILD_TARGETS="just_kmod"
		ECONF_PARAMS="--with-kernel=${KV_DIR} --enable-verbose-build"
		MODULE_NAMES="pvfs2(fs::src/kernel/linux-2.6)"
	fi

	#Notice I don't include --disable-static because it makes the linker fail due to a missing library
	#needed by LIBS_THREADED += -lpvfs2-threaded. However that library is only compiled if static is enabled. Anyway
	#it is used to build pvfs2-client-core-threaded, which is not installed by make kmod_install (unstable perhaps?)
	ECONF_PARAMS="${ECONF_PARAMS} --enable-mmap-racache $(use_enable !static shared)"
	ECONF_PARAMS="${ECONF_PARAMS} $(use_enable gtk karma)"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.5.1-destdir.patch
	epatch "${FILESDIR}"/${PV}-link-librt-properly.patch
	epatch "${FILESDIR}"/${PV}-soname.patch
	epatch "${FILESDIR}"/${PV}-as-needed.patch

	#Fix so we can install kernapps separate from kmod_install
	sed -i '/^kmod_install: kmod/{
		s/\(kmod_install:.*kernapps\)\(.*\)/\1_install\2\n.PHONY: kernapps_install\nkernapps_install: kernapps/}' Makefile.in
	sed -i '/^kmod24_install: kmod/{
		s/\(kmod24_install:.*kernapps\)\(.*\)/\1_install\2\n.PHONY: kernapps_install\nkernapps_install: kernapps/}' Makefile.in

	if kernel_is gt 2 6 20 ; then
		epatch "${FILESDIR}"/${PV}-register_sysctl_table.patch
	fi

	if kernel_is ge 2 6 22 ; then
		epatch "${FILESDIR}"/${PV}-kmem-and-dtor-fix.patch
	fi

	#This is needed when gcc doesn't support -Wno-pointer-sign. Now it will give us some warnings so it also removes -Werror.
	#It's unsafe, not recommended
	if [ "$(gcc-major-version)" -lt "4" ]; then
		ewarn "It's recommended to use gcc >= 4.0 to avoid the following patch"
		epatch "${FILESDIR}"/${PV}-no-pointer-sign.patch
	fi

	AT_M4DIR="maint/config" eautoreconf
}

src_compile() {
	econf ${ECONF_PARAMS} || die "Unable to run econf ${ECONF_PARAMS}"
	linux-mod_src_compile || die "Unable to linux-mod_src_compile"
	emake kernapps || die "Unable to make kernapps."
	emake all || die "Unable to make all."
}

src_install() {
	linux-mod_src_install || die "linux-mod_src_install failed"
	emake DESTDIR="${D}" kernapps_install || die "kernapps_install failed"
	emake DESTDIR="${D}" install || die "install failed"
	newinitd "${FILESDIR}"/pvfs2-server.rc pvfs2-server
	newconfd "${FILESDIR}"/pvfs2-server.conf pvfs2-server
	newinitd "${FILESDIR}"/pvfs2-client-init.d pvfs2-client
	newconfd "${FILESDIR}"/pvfs2-client.conf pvfs2-client
	dodoc AUTHORS CREDITS ChangeLog INSTALL README
	docinto examples
	dodoc examples/{fs.conf,pvfs2-server.rc,server.conf-localhost}
	# this is LARGE (~5mb)
	if use doc; then
		docdir="/usr/share/doc/${PF}/"
		cp -pPR "${S}"/doc "${D}${docdir}"
		rm -rf "${D}${docdir}"/man
	fi
}

pkg_preinst() {
	linux-mod_pkg_preinst
}

pkg_postinst() {
	linux-mod_pkg_postinst
	elog "To enable PVFS2 Server on boot you will have to add it to the"
	elog "default profile, issue the following command as root to do so."
	elog
	elog "rc-update add pvfs2-server default"
}
