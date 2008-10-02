# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ksb26/ksb26-0.0.4.ebuild,v 1.4 2008/10/02 16:58:07 ranger Exp $

inherit linux-mod

DESCRIPTION="A kernel SOCKS bouncer"
HOMEPAGE="http://ksb.sourceforge.net/"
SRC_URI="mirror://sourceforge/ksb/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""
S=${WORKDIR}/${PN}

DEPEND=">=sys-apps/sed-4"

pkg_setup()
{
	if ! kernel_is 2 6; then
		die "${P} can only be built against a 2.6.x kernel!"
	fi

	linux-mod_pkg_setup

	MODULE_NAMES="ksb26(misc:${S}/kernel:${S}/kernel)"
	BUILD_TARGETS="all"
}

src_unpack()
{
	unpack ${A}

	cd "${S}"
	cp "${FILESDIR}/${PN}-kernel-Makefile" kernel/Makefile
	sed -i -e "s:@gcc:\${CC} \${CFLAGS}:" user/Makefile

	#patch to fix compilation with recent kernels
	epatch "${FILESDIR}/${P}_unreg_chrdev.patch" || die "epatch failed"
}

src_compile()
{
	linux-mod_src_compile || die "Kernel module compilation failed!"

	einfo "Preparing userspace tools"
	cd "${S}/user"
	emake || die "Userspace tools compilation failed!"
}

src_install()
{
	linux-mod_src_install

	cd "${S}"
	dobin user/ksb26manager

	dodir /etc/ksb26
	insinto /etc/ksb26
	doins thosts.example

	doman ksb26.8.gz
	dodoc AUTHOR README TODO
}

pkg_postinst()
{
	linux-mod_pkg_postinst

	if [ ! -e "${ROOT}/dev/ksb26" ]; then
		mknod "${ROOT}/dev/ksb26" c 254 0
	fi

	einfo "Read man page (man ksb26) for informations about the use of ksb26"
	einfo "Don't forget to set target hosts in /etc/ksb26/thosts"
}

pkg_postrm()
{
	if [ -e "${ROOT}/dev/ksb26" ]; then
		rm "${ROOT}/dev/ksb26"
	fi
}
